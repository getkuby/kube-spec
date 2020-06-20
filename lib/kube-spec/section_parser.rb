module KubeSpec
  class SectionParser
    def self.parse(cli_text, header_re)
      new(cli_text, header_re).sections
    end

    attr_reader :cli_text, :header_re

    def initialize(cli_text, header_re)
      @cli_text = cli_text
      @header_re = header_re

      parse
    end

    def sections
      @sections ||= {}
    end

    private

    def parse
      each_index.each_cons(2) do |start, finish|
        newline_idx = cli_text.index("\n", start)
        header = cli_text[start..newline_idx].chomp(":\n")
        contents = cli_text[(newline_idx + 1)...finish]
        sections[header] = contents
      end
    end

    def each_index
      return to_enum(__method__) unless block_given?

      last_idx = 0

      loop do
        idx = cli_text.index(header_re, last_idx)

        if idx
          yield idx
          last_idx = cli_text.index("\n", idx)
        else
          yield cli_text.size
          break
        end
      end
    end
  end
end
