require 'kubectl-rb'

module KubeSpec
  class CLI
    HEADER_RE = /^(Usage|[\w\(\) ]+):$/

    class << self
      def commands
        @commands ||= begin
          cli_help = `kubectl --help`
          sections = SectionParser.parse(cli_help, HEADER_RE)

          commands = sections.flat_map do |section, section_text|
            next [] if section == 'Usage'

            section_text.strip.split("\n").map do |sc|
              sc.strip.split(' ').first
            end
          end

          CommandTrie.from_list(
            commands.map do |command|
              CommandParser.parse([command], `#{kubectl} #{command} --help`)
            end
          )
        end
      end

      def global_options
        @global_options ||= OptionsParser.parse(`#{kubectl} options`)
      end

      def kubectl
        KubectlRb.executable
      end
    end
  end
end
