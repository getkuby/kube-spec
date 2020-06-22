require 'json'

module KubeSpec
  module Handlers
    class GetHandler < Handler
      def evaluate(statement)
        kind = KubeSpec.normalize_kind(statement.args[0])
        resource_name = statement.args[1]
        resources = []

        if resource_name
          if found = cluster.get_resource(kind, resource_name)
            resources << found
          end
        else
          resources += cluster.get_resources(kind)
        end

        case statement.command_options[:output]
          when 'name'
            resources.each do |resource|
              puts "#{kind}/#{resource['metadata']['name']}"
            end
          when 'json'
            if resource_name
              unless resources.empty?
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
