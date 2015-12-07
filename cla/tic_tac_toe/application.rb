# require_relative './option_parser'
require_relative './game'

module TicTacToe
  class Application    
    def initialize(argv)
      start_app
    end

    def start_app
      puts
      puts 'Welcome to TicTacToe'

      loop do  
        puts
        puts 'Choose Game type : '
        puts '    pvp: player   vs  player'
        puts '    pvc: player   vs  computer'
        puts '    cvp: computer vs  player'
        puts '    cvc: computer vs  computer'
        puts '    exit: leave game'
        puts

        game = gets.chomp
        break if game == 'exit'
        game_type(game)

        puts
        puts 'Play again?'
      end
      puts
      puts 'Thankyou for playing.'
    end

    def setup_game(p1, p2)
      @game = Game.new(p1, p2)
      play
    end

    def play
      @game.play
    end

    def game_type(game)
      case game
      when 'pvp'
        setup_game(HumanPlayer, HumanPlayer)
      when 'pvc'
        setup_game(HumanPlayer, ComputerPlayer)
      when 'cvp'
        setup_game(ComputerPlayer, HumanPlayer)
      when 'cvc'
        setup_game(ComputerPlayer, ComputerPlayer)
      else
        nil
      end
    end
  end
end
