module KubeSpec
  module Handlers
    class ConfigHandler < ClientHandler
      def evaluate(statement)
        case statement.command.cmd[1]
          when 'get-contexts', 'get-context'
            get_contexts(statement)
        end
      end

      private

      def get_contexts(statement)
        contexts = []

        if context = statement.args[0]
          if found = client.kubeconfig[:contexts].find { |c| c[:name] == context }
            contexts << found
          end
        else
          contexts += client.kubeconfig[:contexts]
        end

        contexts.each do |c|
          if statement.command_options[:output] == 'name'
            puts c[:name]
          end
        end
      end
    end
  end
end
