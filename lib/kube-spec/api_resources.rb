module KubeSpec
  class ApiResources
    ALL_VERBS_COLL = %w(create delete deletecollection get list patch update watch).freeze
    ALL_VERBS = %w(create delete get list patch update watch).freeze

    def self.create(api_resources = nil)
      new(api_resources || defaults.dup)
    end

    def self.defaults
      @defaults ||= [
        ApiResource.new(
          name: 'configmaps',
          short_names: ['cm'],
          namespaced: true,
          kind: 'ConfigMap',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'events',
          short_names: ['ev'],
          namespaced: true,
          kind: 'Event',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'namespaces',
          short_names: ['ns'],
          namespaced: false,
          kind: 'Namespace',
          verbs: ALL_VERBS
        ),

        ApiResource.new(
          name: 'nodes',
          short_names: ['no'],
          namespaced: false,
          kind: 'Node',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'persistentvolumeclaims',
          short_names: ['pvc'],
          namespaced: true,
          kind: 'PersistentVolumeClaim',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'persistentvolumes',
          short_names: ['pv'],
          namespaced: false,
          kind: 'PersistentVolume',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'pods',
          short_names: ['po'],
          namespaced: true,
          kind: 'Pod',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'secrets',
          namespaced: true,
          kind: 'Secret',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'serviceaccounts',
          short_names: ['sa'],
          namespaced: true,
          kind: 'ServiceAccount',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'services',
          short_names: ['svc'],
          namespaced: true,
          kind: 'Service',
          verbs: ALL_VERBS
        ),

        ApiResource.new(
          name: 'customresourcedefinitions',
          short_names: ['crd', 'crds'],
          namespaced: false,
          api_group: 'apiextensions.k8s.io',
          kind: 'CustomResourceDefinition',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'daemonsets',
          short_names: ['ds'],
          namespaced: true,
          api_group: 'apps',
          kind: 'DaemonSet',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'deployments',
          short_names: ['deploy'],
          namespaced: true,
          api_group: 'apps',
          kind: 'Deployment',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'replicasets',
          short_names: ['rs'],
          namespaced: true,
          api_group: 'apps',
          kind: 'ReplicaSet',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'statefulsets',
          short_names: ['sts'],
          namespaced: true,
          api_group: 'apps',
          kind: 'StatefulSet',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'cronjobs',
          short_names: ['cj'],
          namespaced: true,
          api_group: 'batch',
          kind: 'CronJob',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'jobs',
          namespaced: true,
          api_group: 'batch',
          kind: 'Job',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'events',
          short_names: ['ev'],
          namespaced: true,
          api_group: 'events.k8s.io',
          kind: 'Event',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'ingresses',
          short_names: ['ing'],
          namespaced: true,
          api_group: 'extensions',
          kind: 'Ingress',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'ingresses',
          short_names: ['ing'],
          namespaced: true,
          api_group: 'networking.k8s.io',
          kind: 'Ingress',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'podsecuritypolicies',
          short_names: ['psp'],
          namespaced: false,
          api_group: 'policy',
          kind: 'PodSecurityPolicy',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'clusterrolebindings',
          namespaced: false,
          api_group: 'rbac.authorization.k8s.io',
          kind: 'ClusterRoleBinding',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'clusterroles',
          namespaced: false,
          api_group: 'rbac.authorization.k8s.io',
          kind: 'ClusterRole',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'rolebindings',
          namespaced: true,
          api_group: 'rbac.authorization.k8s.io',
          kind: 'RoleBinding',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'roles',
          namespaced: true,
          api_group: 'rbac.authorization.k8s.io',
          kind: 'Role',
          verbs: ALL_VERBS_COLL
        ),

        ApiResource.new(
          name: 'storageclasses',
          short_names: ['sc'],
          namespaced: false,
          api_group: 'storage.k8s.io',
          kind: 'StorageClass',
          verbs: ALL_VERBS_COLL
        )
      ].freeze
    end


    include Enumerable

    attr_reader :api_resources

    def initialize(api_resources)
      @api_resources = api_resources
    end

    def normalize_kind(str)
      str = str.downcase

      found = api_resources.find do |api_resource|
        api_resource.kind.downcase == str ||
          api_resource.name.downcase == str ||
          api_resource.short_names.include?(str)
      end

      found&.kind || str
    end

    def get(kind)
      api_resources.find do |api_resource|
        api_resource.kind == kind
      end
    end

    def each(&block)
      api_resources.each(&block)
    end
  end
end
