module KubeSpec
  class Command
    attr_reader :cmd, :subcommands, :options

    def initialize(cmd, subcommands, options)
      @cmd = cmd
      @subcommands = subcommands
      @options = options
    end
  end
end
