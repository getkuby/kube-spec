module KubeSpec
  class Table
    PADDING = 3

    attr_reader :headers, :rows

    def initialize(headers, rows)
      @headers = headers  # array of strings
      @rows = rows        # array of arrays of strings
    end

    def to_s
      [justify(headers).join, *rows.map { |r| justify(r).join }].join("\n")
    end

    private

    def justify(row)
      row.map.with_index do |h, idx|
        h.ljust(col_widths[idx], ' ')
      end
    end

    def col_widths
      @col_widths ||= headers.each_with_index.map do |header, idx|
        [header.size, *rows.map { |r| r[idx].size }].max + PADDING
      end
    end
  end
end
