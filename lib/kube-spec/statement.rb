module KubeSpec
  class Statement
    attr_reader :global_options, :command, :command_options

    def initialize(global_options, command, command_options)
      @global_options = global_options
      @command = command
      @command_options = command_options
    end
  end
end
