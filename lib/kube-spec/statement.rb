module KubeSpec
  class Statement
    attr_reader :global_options, :command, :command_options, :args, :arglist

    def initialize(global_options, command, command_options, args, arglist)
      @global_options = global_options
      @command = command
      @command_options = command_options
      @args = args
      @arglist = arglist
    end
  end
end
