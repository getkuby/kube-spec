require 'stringio'

module KubeSpec
  class Server
    DEFAULT_URI = 'druby://localhost:8787'.freeze

    attr_reader :cluster

    def initialize
      @cluster = Cluster.new
    end

    def evaluate(statement)
      old_stdout = $stdout
      $stdout = StringIO.new
      handler_for(statement).evaluate(statement)
      $stdout.string
    ensure
      $stdout = old_stdout
    end

    private

    def handler_for(statement)
      handlers[statement.command.cmd] ||= begin
        handler_klass = KubeSpec::Handlers.handler_for(statement.command.cmd)
        handler_klass.new(cluster)
      end
    end

    def handlers
      @handlers ||= {}
    end
  end
end
