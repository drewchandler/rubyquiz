require 'spec_helper'
require 'stringio'


module Sokoban
  describe Level do
    let(:basic_level) do
      <<'LEVEL'
#####
#.o@#
#####
LEVEL
    end

    describe '.new' do
      it 'read in the level from a file handle' do
        level = Level.new(StringIO.new(basic_level))

        level.to_s.should == basic_level
      end
    end

    describe '#completed?' do
      it 'should be false when a level has unstored boxes' do
        level = Level.new(StringIO.new(basic_level))

        level.should_not be_completed
      end

      it 'should be true when a level has no unstored boxes' do
        level = Level.new(StringIO.new(<<'LEVEL'))
#####
#*@ #
#####
LEVEL

        level.should be_completed
      end

      it 'should be true when a level has no boxes' do
        level = Level.new(StringIO.new(<<'LEVEL'))
###
#@#
###
LEVEL

        level.should be_completed
      end
    end

    describe '#move_man' do
      context 'directions' do
        subject do
          Level.new(StringIO.new(<<'LEVEL'))
#####
#   #
# @ #
#   #
#####
LEVEL
        end

        it 'should be able to move up' do
          subject.move_man(UP)

          subject.to_s.should == <<'LEVEL'
#####
# @ #
#   #
#   #
#####
LEVEL
        end

        it 'should be able to move down' do
          subject.move_man(DOWN)

          subject.to_s.should == <<'LEVEL'
#####
#   #
#   #
# @ #
#####
LEVEL
        end

        it 'should be able to move left' do
          subject.move_man(LEFT)

          subject.to_s.should == <<'LEVEL'
#####
#   #
#@  #
#   #
#####
LEVEL
        end

        it 'should be able to move right' do
          subject.move_man(RIGHT)

          subject.to_s.should == <<'LEVEL'
#####
#   #
#  @#
#   #
#####
LEVEL
        end
      end

      it 'should show the man on storage differently' do
        level = Level.new(StringIO.new(<<'LEVEL'))
#####
# .@#
#####
LEVEL
        level.move_man(LEFT)

        level.to_s.should == <<'LEVEL'
#####
# + #
#####
LEVEL
      end

      it 'should show storage in the vacated square after the man moves off of storage' do
        level = Level.new(StringIO.new(<<'LEVEL'))
#####
# + #
#####
LEVEL
        level.move_man(RIGHT)

        level.to_s.should == <<'LEVEL'
#####
# .@#
#####
LEVEL
      end

      it 'should show the man standing on storage after he pushes a box off of it' do
        level = Level.new(StringIO.new(<<'LEVEL'))
#####
#@*.#
#####
LEVEL
        level.move_man(RIGHT)

        level.to_s.should == <<'LEVEL'
#####
# +*#
#####
LEVEL
      end

      it 'should not be able to move through walls' do
        level = Level.new(StringIO.new(basic_level))
        level.move_man(RIGHT)

        level.to_s.should == basic_level
      end

      it 'should not be able to push a box through walls' do
        level = Level.new(StringIO.new(<<'LEVEL'))
####
#@o#
####
LEVEL
        level.move_man(RIGHT)

        level.to_s.should == <<'LEVEL'
####
#@o#
####
LEVEL
      end

      it 'should not be able to push a box through a box' do
        level = Level.new(StringIO.new(<<'LEVEL'))
######
#@oo #
######
LEVEL
        level.move_man(RIGHT)

        level.to_s.should == <<'LEVEL'
######
#@oo #
######
LEVEL
      end

      it 'should not be able to push a box through a box on storage' do
        level = Level.new(StringIO.new(<<'LEVEL'))
######
#@o* #
######
LEVEL
        level.move_man(RIGHT)

        level.to_s.should == <<'LEVEL'
######
#@o* #
######
LEVEL
      end

      it 'should be able to push boxes' do
        level = Level.new(StringIO.new(<<'LEVEL'))
#####
# o@#
#####
LEVEL
        level.move_man(LEFT)

        level.to_s.should == <<'LEVEL'
#####
#o@ #
#####
LEVEL
      end

      it 'should be able to push boxes on to storage' do
        level = Level.new(StringIO.new(basic_level))
        level.move_man(LEFT)

        level.to_s.should == <<'LEVEL'
#####
#*@ #
#####
LEVEL
      end
    end
  end
end
