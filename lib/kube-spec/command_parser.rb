module KubeSpec
  class CommandParser
    HEADER_RE = /^(Available Commands|Usage|Options):$/

    class << self
      def parse(command_names, command_help)
        sections = SectionParser.parse(command_help, HEADER_RE)
        subcommands = []

        if subs = sections['Available Commands']
          subcommands = subs.split("\n").map { |cmd| cmd.strip.split(' ').first }
        end

        subcommands.map! do |subcommand_name|
          full_name = [*command_names, subcommand_name]
          parse(full_name, `#{kubectl} #{full_name.join(' ')} --help`)
        end

        options = if opts = sections['Options']
          OptionsParser.parse(opts)
        else
          Options.new
        end

        Command.new(command_names, subcommands, options)
      end

      def kubectl
        CLI.kubectl
      end
    end
  end
end
