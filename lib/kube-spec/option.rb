module KubeSpec
  class Option
    def self.coerce_value(val)
      if val == "''"
        nil
      elsif val.start_with?("'") && val.end_with?("'")
        val[1..-2]
      elsif val =~ /^\d+$/
        val.to_i
      elsif val == 'true'
        true
      elsif val == 'false'
        false
      elsif val == '[]'
        []
      else
        val
      end
    end

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
