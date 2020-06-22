module KubeSpec
  module Handlers
    autoload :ConfigHandler, 'kube-spec/handlers/config_handler'
    autoload :GetHandler, 'kube-spec/handlers/get_handler'
    autoload :Handler,    'kube-spec/handlers/handler'

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

        unless current
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

