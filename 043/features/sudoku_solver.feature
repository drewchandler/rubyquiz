Feature: Sudoku solver
  Given I am a person incapable of solving a sudoku
  In order to get a solution
  I want a solver

  Scenario: solve a sudoku from the command line
    Given a file named "puzzle" with:
    """
    +-------+-------+-------+
    | _ 6 _ | 1 _ 4 | _ 5 _ |
    | _ _ 8 | 3 _ 5 | 6 _ _ |
    | 2 _ _ | _ _ _ | _ _ 1 |
    +-------+-------+-------+
    | 8 _ _ | 4 _ 7 | _ _ 6 |
    | _ _ 6 | _ _ _ | 3 _ _ |
    | 7 _ _ | 9 _ 1 | _ _ 4 |
    +-------+-------+-------+
    | 5 _ _ | _ _ _ | _ _ 2 |
    | _ _ 7 | 2 _ 6 | 9 _ _ |
    | _ 4 _ | 5 _ 8 | _ 7 _ |
    +-------+-------+-------+
    """
    When I run "ruby -I../../lib ../../bin/sudoku_solver puzzle"
    Then the output should contain:
    """
    +-------+-------+-------+
    | 9 6 3 | 1 7 4 | 2 5 8 |
    | 1 7 8 | 3 2 5 | 6 4 9 |
    | 2 5 4 | 6 8 9 | 7 3 1 |
    +-------+-------+-------+
    | 8 2 1 | 4 3 7 | 5 9 6 |
    | 4 9 6 | 8 5 2 | 3 1 7 |
    | 7 3 5 | 9 6 1 | 8 2 4 |
    +-------+-------+-------+
    | 5 8 9 | 7 1 3 | 4 6 2 |
    | 3 1 7 | 2 4 6 | 9 8 5 |
    | 6 4 2 | 5 9 8 | 1 7 3 |
    +-------+-------+-------+
    """
