module KubeSpec
  class ApiResource
    attr_reader :name, :short_names, :api_group, :namespaced
    attr_reader :kind, :verbs

    def initialize(name:, namespaced:, kind:, verbs:, short_names: [], api_group: nil)
      @name = name
      @namespaced = namespaced
      @kind = kind
      @verbs = verbs
      @short_names = short_names
      @api_group = api_group
    end
  end
end
