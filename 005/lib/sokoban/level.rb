module Sokoban
  class Level
    def initialize(file)
      @rows = file.readlines.map { |l| l.split(//) }
    end

    def move_man(direction)
      (row, col) = find_man
      (dest_row, dest_col) = determine_destination(row, col, direction)

      do_move(row, col, dest_row, dest_col) if legal_move?(row, col, dest_row, dest_col)
    end

    def completed?
      ! @rows.find { |row| row.include?('o') }
    end

    def to_s
      @rows.flatten.join
    end

    private
      def find_man
        @rows.each_with_index do |r, i|
          if col = r.index { |c| c == '@' || c == '+' }
            return [i, col]
          end
        end
      end

      def determine_destination(row, col, direction)
        case direction
          when UP then row -= 1
          when DOWN then row += 1
          when LEFT then col -= 1
          when RIGHT then col += 1
        end

        [row, col]
      end

      def legal_move?(row, col, dest_row, dest_col)
        dx = dest_row - row
        dy = dest_col - col

        !wall?(dest_row, dest_col) && !(box?(dest_row, dest_col) &&
           (wall?(dest_row + dx, dest_col + dy) || box?(dest_row + dx, dest_col + dy)))
      end

      def do_move(row, col, dest_row, dest_col)
        @rows[row][col] = storage?(row, col) ? '.' : ' '
        push_box(row, col, dest_row, dest_col) if box?(dest_row, dest_col)
        @rows[dest_row][dest_col] = storage?(dest_row, dest_col) ? '+' : '@'
      end

      def push_box(row, col, dest_row, dest_col)
        dx = dest_row - row
        dy = dest_col - col

        @rows[dest_row + dx][dest_col + dy] =
          storage?(dest_row + dx, dest_col + dy) ? '*' : 'o'
      end

      def storage?(row, col)
        @rows[row][col] == '.' || @rows[row][col] == '+' || @rows[row][col] == '*'
      end

      def box?(row, col)
        @rows[row][col] == 'o' || @rows[row][col] == '*'
      end

      def wall?(row, col)
        @rows[row][col] == '#'
      end
  end
end
