require 'stringio'

module KubeSpec
  class TestSystem
    DEFAULT_KUBECONFIG = {
      clusters: [{
        name: 'test-cluster',
        cluster: {
          server: 'https://test.com'
        },
      }],
      contexts: [{
        name: 'test-context',
        context: {
          cluster: 'test-cluster',
          user: 'test-user'
        }
      }],
      :'current-context' => 'test-context',
      users: [{
        name: 'test-user'
      }]
    }.freeze

    attr_reader :kubeconfig

    def initialize(kubeconfig = nil)
      # deep copy
      @kubeconfig ||= Marshal.load(Marshal.dump(DEFAULT_KUBECONFIG))
    end

    def cluster_for(cluster_name)
      clusters[cluster_name] ||= Cluster.new(cluster_name)
    end

    def current_context
      kubeconfig[:'current-context']
    end

    def context_for(context_name)
      kubeconfig[:contexts].find { |ctx| ctx[:name] == context_name }
    end

    def evaluate(argv)
      statement = KubeSpec::CLIParser.parse(argv)
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
        handler_klass = Handlers.handler_for(statement.command.cmd)

        if handler_klass.server?
          context = context_for(statement.global_options[:context] || current_context)
          cluster = cluster_for(context[:context][:cluster])
          handler_klass.new(cluster)
        else
          handler_klass.new(self)
        end
      end
    end

    def clusters
      @clusters ||= {}
    end

    def handlers
      @handlers ||= {}
    end
  end
end
