require 'json'

module KubeSpec
  module Handlers
    class GetHandler < ServerHandler
      def evaluate(statement)
        kind = cluster.normalize_kind(statement.args[0])
        resource_name = statement.args[1]
        namespace = statement.global_options[:namespace]
        resources = []

        if resource_name
          if found = cluster.get_resource(kind, resource_name, namespace)
            resources << found
          end
        else
          resources += cluster.get_resources(kind, namespace)
        end

        case statement.command_options[:output]
          when 'name'
            resources.each do |resource|
              puts "#{kind.downcase}/#{resource['metadata']['name']}"
            end
          when 'json'
            if resource_name
              if resources.empty?
                raise "Error from server (NotFound): namespaces \"#{resource_name}\" not found"
              else
                puts JSON.pretty_generate(resources.first)
              end
            else
              puts JSON.pretty_generate({ apiVersion: 'v1', kind: 'List', items: resources })
            end
        end
      end
    end
  end
end
