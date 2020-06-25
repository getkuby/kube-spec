module KubeSpec
  module Handlers
    class ApiResourcesHandler < ServerHandler
      HEADERS = %w(NAME SHORTNAMES APIGROUP NAMESPACED KIND VERBS).freeze

      def evaluate(statement)
        api_resources = if statement.command_options[:namespaced]
          namespaced_resources
        else
          non_namespaced_resources
        end

        rows = api_resources.map do |api_resource|
          [
            api_resource.name,
            api_resource.short_names.join(','),
            api_resource.api_group || '',
            api_resource.namespaced.to_s,
            api_resource.kind,
            "[#{api_resource.verbs.join(' ')}]"
          ]
        end

        puts Table.new(HEADERS, rows).to_s
      end

      private

      def namespaced_resources
        cluster.api_resources.select(&:namespaced)
      end

      def non_namespaced_resources
        cluster.api_resources.reject(&:namespaced)
      end
    end
  end
end
