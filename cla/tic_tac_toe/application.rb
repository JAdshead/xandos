require_relative './option_parser'
require_relative './game'

module TicTacToe
  class Application
    attr_reader :options, :opt_parser
    
    def initialize(argv)
      @opt_parser = TicTacToeOptionsParser.setup_parser(argv)
      opt_parser.parse(argv)
      game_type(argv)
    end

    def setup_game(p1, p2)
      @game = Game.new(p1, p2)
      play
    end

    def play
      @game.play
    end

    def game_type(argv)
      case argv[0]
      when 'pvp'
        setup_game(HumanPlayer, HumanPlayer)
      when 'pvc'
        setup_game(HumanPlayer, ComputerPlayer)
      when 'cvp'
        setup_game(ComputerPlayer, HumanPlayer)
      when 'cvc'
        setup_game(ComputerPlayer, ComputerPlayer)
      else
        puts opt_parser
      end
    end
  end
end
