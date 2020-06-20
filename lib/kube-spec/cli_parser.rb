module KubeSpec
  class CLIParser
    def self.parse(args)
      new(args).statement
    end

    attr_reader :arglist, :statement

    def initialize(arglist)
      @arglist = arglist

      parse
    end

    private

    def parse
      args = arglist.dup
      global_options = extract_options_from(args, CLI.global_options)
      command = extract_command_from(args)
      command_options = extract_options_from(args, command.options)
      @statement = Statement.new(global_options, command, command_options)
    end

    def extract_options_from(args, possible_options)
      provided_options = find_options_in(args, possible_options)
      all_options = compile_options_considering(provided_options, possible_options, args)
      indices = provided_options.flat_map { |_, po| [po[:index], po[:index] + 1] }

      args.reject!.with_index do |_, idx|
        indices.include?(idx)
      end

      all_options
    end

    def find_options_in(args, possible_options)
      args.each_with_object({}).with_index do |(arg, ret), idx|
        if arg.start_with?('-')
          arg = normalize(arg)

          if option = possible_options[arg]
            ret[option.name] = { index: idx, option: option }
          end
        end
      end
    end

    def compile_options_considering(provided_options, possible_options, args)
      possible_options.each_with_object({}) do |option, ret|
        if opt = provided_options[option.name]
          ret[option.name] = args[opt[:index] + 1]
        else
          ret[option.name] = option.default
        end
      end
    end

    def normalize(arg)
      arg.sub(/^-{1,2}([^-])/, '\1')
    end

    def extract_command_from(args)
      current = CLI.commands

      args.reject! do |arg|
        unless arg.start_with?('-')
          if nxt = current.traverse(arg)
            current = nxt
          end
        end
      end

      current&.value
    end
  end
end
