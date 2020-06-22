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
        options << Option.new(abbrev_name, name, Option.coerce_value(default))
      end
    end
  end
end
