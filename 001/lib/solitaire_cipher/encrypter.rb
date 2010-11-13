module SolitaireCipher
  class Encrypter
    def self.encrypt(string, deck = Deck.new)
      string.upcase!.gsub!(/[^A-Z]/, '')
      string += 'X' * (5 - (string.length % 5)) if (string.length % 5) != 0

      keystream = []
      keystream_length = string.length
      while keystream.length < keystream_length
        next unless key = deck.generate_key

        keystream << key.ord - 64
      end

      encrypted_string = string.each_char.map do |char|
        if char == ' '
          ' '
        else
          char = (char.ord - 64) + keystream.shift
          char -= 26 if char > 26

          (char + 64).chr
        end
      end

      encrypted_string.each_slice(5).collect{ |s| s.join }.join(' ')
    end
  end
end
