module SolitaireCipher
  class Deck
    attr_accessor :cards

    def initialize
      @cards = (1..54).to_a
    end

    def generate_key
      move_card(53, 1)
      move_card(54, 2)

      joker_indices = find_jokers
      triple_cut(@cards[joker_indices[0]], @cards[joker_indices[1]])

      count_cut(@cards[53])


      output_key
    end

    def move_card(card, movement)
      index = @cards.index(card)

      destination = index + movement
      destination = destination - 53 if destination > 53

      @cards.delete_at(index)
      @cards.insert(destination, card)
    end

    def triple_cut(top_card, bottom_card)
      top_index = @cards.index(top_card)
      bottom_index = @cards.index(bottom_card)

      @cards = @cards[(bottom_index + 1)..54] + @cards[top_index..bottom_index] + @cards[0..(top_index - 1)]
    end

    def find_jokers
      results = []
      @cards.each_index do |i|
        if @cards[i] == 53 || @cards[i] == 54
          results << i

          break if results.size == 2
        end
      end

      results
    end

    def count_cut(n)
      @cards = @cards[(n..52)] + @cards[(0..(n - 1))] << @cards[53]
    end

    def output_key
      key_card = @cards[@cards[0] == 54 ? 53 : @cards[0]]

      if key_card > 52
        nil
      else
        key_card -= 26 if key_card > 26
        (key_card + 64).chr
      end
    end
  end
end
