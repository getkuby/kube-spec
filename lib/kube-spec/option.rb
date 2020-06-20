module KubeSpec
  class Option
    attr_reader :abbrev_name, :name, :default

    def initialize(abbrev_name, name, default)
      @abbrev_name = abbrev_name
      @name = name
      @default = default
    end

    def abbrev?
      !!abbrev_name
    end

    def to_s
      ''.tap do |result|
        names = []
        names << "-#{abbrev_name}" if abbrev_name
        names << "--#{name}"
        result << names.join(', ')
        result << "=#{default}" if default
      end
    end
  end
end
