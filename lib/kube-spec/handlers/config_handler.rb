module KubeSpec
  module Handlers
    class ConfigHandler < Handler
      def evaluate(statement)
        case statement.command.cmd[1]
          when 'get-contexts'
            get_contexts(statement)
        end
      end

      private

      def get_contexts(statement)
        clusters = []

        if context = statement.args[0]
          if found = cluster.kubeconfig[:clusters].find { |c| c[:name] == context }
            clusters << found
          end
        else
          clusters += cluster.kubeconfig[:clusters]
        end

        clusters.each do |c|
          if statement.command_options[:output] == 'name'
            puts c[:name]
          end
        end
      end
    end
  end
end
