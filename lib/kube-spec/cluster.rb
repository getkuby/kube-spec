require 'kube-dsl'

module KubeSpec
  class Cluster
    attr_reader :name, :resources, :api_resources, :kubeconfig

    def initialize(name)
      @name = name

      @resources = [
        KubeDSL.namespace do
          metadata { name 'default' }
        end,

        KubeDSL.namespace do
          metadata { name 'kube-node-lease' }
        end,

        KubeDSL.namespace do
          metadata { name 'kube-public' }
        end,

        KubeDSL.namespace do
          metadata { name 'kube-system' }
        end
      ]

      # TODO: do this differently
      @resources.map! { |r| r.to_resource.serialize }

      @api_resources = ApiResources.create
    end

    def get_resources(kind, namespace = nil, selector = {})
      kind = normalize_kind(kind)

      resources.select do |rsrc|
        rsrc_labels = rsrc['metadata']['labels']

        kind == normalize_kind(rsrc['kind']) &&
          rsrc['metadata']['namespace'] == namespace &&
          selector.all? do |k, v|
            rsrc_labels.include?(k) && rsrc_labels[k] == v
          end
      end
    end

    def get_resource(kind, name, namespace = nil)
      kind = normalize_kind(kind)

      resources.find do |rsrc|
        kind == normalize_kind(rsrc['kind']) &&
          name == rsrc['metadata']['name'] &&
          rsrc['metadata']['namespace'] == namespace
      end
    end

    def normalize_kind(str)
      api_resources.normalize_kind(str)
    end

    def get_api_resource(kind)
      api_resources.find do |api_resource|
        api_resource.kind == kind
      end
    end
  end
end
