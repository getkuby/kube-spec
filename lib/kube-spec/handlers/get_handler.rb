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

        resources.each do |resource|
          case statement.command_options[:output]
            when 'name'
              puts "#{kind}/#{resource[:metadata][:name]}"
            when 'json'
              puts JSON.pretty_generate(resource)
          end
        end
      end
    end
  end
end
