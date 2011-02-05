module SudokuSolver
  module CLI
    def self.run(args)
      puzzle = Puzzle.new(File.open(args[0], 'r'))
      puts Solver.solve(puzzle)
    end
  end
end
