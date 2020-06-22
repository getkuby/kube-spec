require 'kube-dsl'

module KubeSpec
  class Cluster
    attr_reader :resources

    def initialize
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
    end

    def kubeconfig
      @kubeconfig ||= {
        clusters: [{
          name: 'test-cluster',
          cluster: {
            server: 'https://test.com'
          },
        }],
        contexts: [{
          name: 'test-context',
          context: {
            cluster: 'test-cluster',
            user: 'test-user'
          }
        }],
        :'current-context' => 'test-context',
        users: [{
          name: 'test-user'
        }]
      }
    end

    def get_resources(kind, namespace = nil, selector = {})
      kind = KubeSpec.normalize_kind(kind)

      resources.select do |rsrc|
        rsrc_labels = rsrc['metadata']['labels']

        kind == KubeSpec.normalize_kind(rsrc['kind']) &&
          rsrc['metadata']['namespace'] == namespace &&
          selector.all? do |k, v|
            rsrc_labels.include?(k) && rsrc_labels[k] == v
          end
      end
    end

    def get_resource(kind, name)
      kind = KubeSpec.normalize_kind(kind)

      resources.find do |rsrc|
        kind == KubeSpec.normalize_kind(rsrc['kind']) &&
          name == rsrc['metadata']['name']
      end
    end
  end
end
