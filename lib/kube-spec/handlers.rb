module KubeSpec
  module Handlers
    autoload :ApiResourcesHandler, 'kube-spec/handlers/api_resources_handler'
    autoload :ApplyHandler,        'kube-spec/handlers/apply_handler'
    autoload :ClientHandler,       'kube-spec/handlers/client_handler'
    autoload :ConfigHandler,       'kube-spec/handlers/config_handler'
    autoload :GetHandler,          'kube-spec/handlers/get_handler'
    autoload :ServerHandler,       'kube-spec/handlers/server_handler'
    autoload :VersionHandler,      'kube-spec/handlers/version_handler'

    class MissingHandlerError < StandardError; end

    class << self
      def register_handler(cmds, klass)
        handlers.add(cmds, klass)
      end

      def handler_for(cmds)
        current = handlers.root

        cmds.each do |cmd|
          if nxt = current.traverse(cmd)
            current = nxt
          else
            break
          end
        end

        if !current || !current.value
          raise MissingHandlerError, "handler for #{cmds.inspect} not found"
        end

        current.value
      end

      private

      def handlers
        @handlers ||= Trie.new
      end
    end
  end
end

KubeSpec::Handlers.register_handler(['get'], KubeSpec::Handlers::GetHandler)
KubeSpec::Handlers.register_handler(['config'], KubeSpec::Handlers::ConfigHandler)
KubeSpec::Handlers.register_handler(['version'], KubeSpec::Handlers::VersionHandler)
KubeSpec::Handlers.register_handler(['api-resources'], KubeSpec::Handlers::ApiResourcesHandler)
KubeSpec::Handlers.register_handler(['apply'], KubeSpec::Handlers::ApplyHandler)
