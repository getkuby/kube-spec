module KubeSpec
  class Options
    include Enumerable

    attr_reader :options

    def initialize
      @options = []
    end

    def <<(option)
      @options << option
    end

    def each(&block)
      options.each(&block)
    end

    def [](name)
      options.find { |o| o.name == name || o.abbrev_name == name }
    end

    def include?(name)
      !!self[name]
    end

    def to_s
      map { |opt| opt.to_s }.join("\n")
    end
  end
end
