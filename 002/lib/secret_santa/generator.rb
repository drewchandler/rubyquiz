module SecretSanta
  class Generator
    def initialize(people)
      @people = people
    end

    def generate_santas
      begin
        santas = @people.zip @people.shuffle
      end while santas.any? { |pair| pair[0].last_name == pair[1].last_name }

      santas
    end
  end
end
