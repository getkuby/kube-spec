module KubeSpec
  autoload :CLI,           'kube-spec/cli'
  autoload :CLIParser,     'kube-spec/cli_parser'
  autoload :Cluster,       'kube-spec/cluster'
  autoload :Command,       'kube-spec/command'
  autoload :CommandParser, 'kube-spec/command_parser'
  autoload :CommandTrie,   'kube-spec/command_trie'
  autoload :Handlers,      'kube-spec/handlers'
  autoload :OptionsParser, 'kube-spec/options_parser'
  autoload :Options,       'kube-spec/options'
  autoload :Option,        'kube-spec/option'
  autoload :SectionParser, 'kube-spec/section_parser'
  autoload :Server,        'kube-spec/server'
  autoload :Statement,     'kube-spec/statement'
  autoload :Trie,          'kube-spec/trie'

  KIND_MAP = {
    'ns'     => 'namespace',
    'po'     => 'pod',
    'deploy' => 'deployment',
    'sa'     => 'serviceaccount',
    'secret' => 'secret',
    'cm'     => 'configmap',
    'ing'    => 'ingress',
    'svc'    => 'service'
  }

  KINDS = KIND_MAP.values.freeze
  ABBREV_KINDS = KIND_MAP.keys.freeze

  KIND_MAP.merge!(Hash[KINDS.zip(KINDS)])

  KIND_MAP.merge!(
    KINDS.each_with_object({}) do |kind, result|
      plural = if kind.end_with?('s')
        "#{kind}es"
      else
        "#{kind}s"
      end

      result[plural] = kind
    end
  )

  KIND_MAP.freeze

  class << self
    def normalize_kind(kind)
      KIND_MAP[kind.downcase]
    end
  end
end
