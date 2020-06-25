module KubeSpec
  DEFAULT_URI = 'druby://localhost:8787'.freeze

  autoload :ApiResource,   'kube-spec/api_resource'
  autoload :ApiResources,  'kube-spec/api_resources'
  autoload :CLI,           'kube-spec/cli'
  autoload :CLIParser,     'kube-spec/cli_parser'
  autoload :Cluster,       'kube-spec/cluster'
  autoload :Command,       'kube-spec/command'
  autoload :CommandParser, 'kube-spec/command_parser'
  autoload :CommandTrie,   'kube-spec/command_trie'
  autoload :Handlers,      'kube-spec/handlers'
  autoload :Options,       'kube-spec/options'
  autoload :Option,        'kube-spec/option'
  autoload :OptionsParser, 'kube-spec/options_parser'
  autoload :SectionParser, 'kube-spec/section_parser'
  autoload :Statement,     'kube-spec/statement'
  autoload :Table,         'kube-spec/table'
  autoload :TestSystem,    'kube-spec/test_system'
  autoload :Trie,          'kube-spec/trie'
end
