require 'spec_helper'

describe SolitaireCipher::Deck do
  describe '#initialize' do
    it 'should create an unkeyed deck' do
      subject.cards.should == (1..54).to_a
    end
  end

  describe '#generate_key' do
    it 'should move the jokers and perform a triple cut and then do a count cut' do
      subject.generate_key
      subject.cards.should == (2..54).to_a << 1
    end

    it 'should return the letter value of the card that is the top cards number value down from the top' do
      subject.generate_key.should == 'D'
    end
  end

  describe '#move_card' do
    it 'should move the card down the given number of spots' do
      subject.move_card(1,1)

      subject.cards.should == [2, 1] + (3..54).to_a
    end

    it 'should wrap around the deck' do
      subject.move_card(54, 1)

      subject.cards.should == [1, 54] + (2..53).to_a
    end
  end

  describe '#triple_cut' do
    before(:each) { subject.triple_cut(20, 40) }

    it 'should move all cards above the top card beneath the bottom card' do
      subject.cards.slice(35, 19).should == (1..19).to_a
    end

    it 'should move all cards beneath the bottom card above the top card' do
      subject.cards.slice(0, 14).should == (41..54).to_a
    end

    it 'should not touch the cards in between' do
      subject.cards.slice(14, 21).should == (20..40).to_a
    end
  end

  describe '#find_jokers' do
    it 'should find the indices of the jokers' do
      subject.find_jokers.should == [52, 53]
    end
  end

  describe '#count cut' do
    it 'should take the first n cards and put them at the bottom' do
      subject.count_cut(10)

      subject.cards.should == (11..53).to_a + (1..10).to_a + [54]
    end
  end

  describe '#output_key' do
    it 'should return the letter value of the card that is the top cards number value down from the top' do
      subject.output_key.should == 'B'
    end

    it 'should treat joker B as a 53 when counting' do
      subject.cards = [54] + (2..53).to_a << 1

      subject.output_key.should == 'A'
    end

    it 'should return nil when the value card is a joker' do
      subject.cards = [1,54] + (2..53).to_a

      subject.output_key.should be_nil
    end
  end
end
