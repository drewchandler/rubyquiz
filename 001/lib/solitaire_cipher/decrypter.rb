module SolitaireCipher
  class Decrypter
    def self.decrypt(string, deck = Deck.new)
      keystream = deck.generate_keystream(string.length - string.count(' '))

      decrypted_string = string.each_char.map do |char|
        if char == ' '
          ' '
        else
          char = (char.ord - 64) - keystream.shift
          char += 26 if char < 1

          (char + 64).chr
        end
      end.join

      decrypted_string
    end
  end
end
