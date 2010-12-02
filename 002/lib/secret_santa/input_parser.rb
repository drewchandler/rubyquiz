module SecretSanta
  module InputParser
    def self.parse(str)
      parts = str.match /(\S+)\s+(\S+)\s+<([^>]+)>/

      Person.new *parts[1,3]
    end
  end
end
