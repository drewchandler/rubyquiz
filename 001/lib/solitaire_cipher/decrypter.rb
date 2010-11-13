module SolitaireCipher
  class Decrypter
    def self.decrypt(string, deck = Deck.new)
      keystream = []
      keystream_length = string.length - string.count(' ')

      while keystream.length < keystream_length
        next unless key = deck.generate_key

        keystream << key.ord - 64
      end

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
