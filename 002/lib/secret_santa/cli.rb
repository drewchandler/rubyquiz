module SecretSanta
  class CLI
    def run
      people = STDIN.readlines.map { |line| InputParser.parse(line) }
      santas = Generator.new(people).generate_santas

      santas.each { |pair| Mailer.santa_msg(*pair).deliver }
    end
  end
end
