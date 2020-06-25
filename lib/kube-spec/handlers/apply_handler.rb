require 'yaml'

module KubeSpec
  module Handlers
    class ApplyHandler < ServerHandler
      def evaluate(statement)
        YAML.load_stream(File.read(statement.command_options[:filename])) do |doc|
          cluster.resources << doc

          if statement.command_options[:output] == 'name'
            name = doc['metadata']['name']
            api_resource = cluster.get_api_resource(cluster.normalize_kind(doc['kind']))

            if api_resource.api_group
              puts "#{api_resource.kind.downcase}.#{api_resource.api_group}/#{name}"
            else
              puts "#{api_resource.kind.downcase}/#{name}"
            end
          end
        end
      end
    end
  end
end
