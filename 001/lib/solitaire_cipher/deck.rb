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
      triple_cut(joker_indices[0], joker_indices[1])

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

    def triple_cut(top_index, bottom_index)
      @cards = @cards[bottom_index + 1..54] + @cards[top_index..bottom_index] + @cards[0..top_index - 1]
    end

    def find_jokers
      top_joker = @cards.index(53)
      bottom_joker = @cards.index(54)
      top_joker, bottom_joker = bottom_joker, top_joker if top_joker > bottom_joker

      [top_joker, bottom_joker]
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
        key_card
      end
    end
  end
end
