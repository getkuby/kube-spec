module KubeSpec
  class OptionsParser
    def self.parse(options_help)
      new(options_help).options
    end

    attr_reader :options_help

    def initialize(options_help)
      @options_help = options_help
      parse
    end

    def options
      @options ||= Options.new
    end

    private

    def parse
      opts = options_help.split("\n").map(&:strip).select do |opt|
        opt.start_with?('-')
      end

      opts.each do |opt|
        abbrev_name, name, default = opt.match(/-?(\w+)?(?:, )?--([\w-]+)=?([^:]*):/).captures
        options << Option.new(abbrev_name, name, coerce(default))
      end
    end

    def coerce(val)
      if val.start_with?("'") && val.end_with?("'")
        val[1..-2]
      elsif val =~ /^\d+$/
        val.to_i
      elsif val == 'true'
        true
      elsif val == 'false'
        false
      else
        val
      end
    end
  end
end
