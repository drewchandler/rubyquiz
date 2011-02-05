module SudokuSolver
  module Solver
    extend self

    def solve(puzzle)
      do_solve(puzzle, 0, 0)
    end

    private
    def do_solve(puzzle, row, col)
      row, col = find_next_empty(puzzle, row, col)

      if row.nil?
        return puzzle
      else
        potential_solution = nil
        (1..9).each do |try|
          if puzzle.legal_placement?(row, col, try)
            clone = puzzle.clone
            clone.set(row, col, try)

            potential_solution = do_solve(clone, row, col)
            break if potential_solution
          end
        end

        return potential_solution
      end
    end

    def find_next_empty(puzzle, row, col)
      while row < 9 && !puzzle.empty?(row, col)
        if (col += 1) == 9
          col = 0
          row += 1
        end
      end

      row < 9 ? [row, col] : nil
    end
  end
end
