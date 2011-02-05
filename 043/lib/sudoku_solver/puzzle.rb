module SudokuSolver
  class Puzzle
    def initialize(file)
      parse_file(file)
    end

    def legal_placement?(row, col, number)
      check_row(row, number) && check_col(col, number) && check_box(row, col, number)
    end

    def empty?(row, col)
      @data[row][col].nil?
    end

    def set(row, col, value)
      @data[row][col] = value
    end

    def to_s
      out = []
      @data.each_with_index do |row, i|
        if i %3 == 0
          out << '+-------+-------+-------+'
        end
        out << '| ' + row.each_slice(3).map { |s| s.join(' ') }.join(' | ') + ' |'
      end
      out << '+-------+-------+-------+'

      out.join("\n")
    end

    def clone
      Marshal.load(Marshal.dump(self))
    end

    private
    def parse_file(file)
      @data = []
      file.lines.each do |l|
        parts = l.gsub(/[^0-9_]/, '').split(//)
        @data << parts.map { |p| p == '_' ? nil : p.to_i } if parts.length > 0
      end
    end

    def check_row(row, number)
      ! @data[row].index(number)
    end

    def check_col(col, number)
      ! @data.any? { |r| r[col] == number }
    end

    def check_box(row, col, number)
      box = @data[min_bound(row) .. max_bound(row)].map { |b| b[min_bound(col) .. max_bound(col)] }.flatten
      ! box.find { |v| v == number }
    end

    def min_bound(index)
      (index / 3) * 3
    end

    def max_bound(index)
      (index / 3 + 1) * 3 - 1
    end
  end
end
