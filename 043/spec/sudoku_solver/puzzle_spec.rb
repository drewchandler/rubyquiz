require 'spec_helper'
require 'stringio'

module SudokuSolver
  describe Puzzle do
    subject { Puzzle.new(StringIO.new(test_data)) }
    let (:test_data) { <<END }
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
END

    describe '#legal_placement?' do
      it 'should check to see if the number is already in the row' do
        subject.legal_placement?(0, 0, 6).should be_false
      end

      it 'should check to see if the number is already in the col' do
        subject.legal_placement?(0, 0, 2).should be_false
      end

      it 'should check to see if the number is already in the box' do
        subject.legal_placement?(2, 1, 8).should be_false
      end

      it 'should return true if the placement is legal' do
        subject.legal_placement?(0, 0, 3).should be_true
      end
    end

    describe 'empty?' do
      it 'should return true if the spot is empty' do
        subject.empty?(0, 0).should be_true
      end

      it 'should return false if the spot is not empty' do
        subject.empty?(0, 1).should be_false
      end
    end
  end
end
