require_relative './game_manager'
require_relative './ui'

module TicTacToe
  class Application    
    def initialize(argv)
      start_app
    end

    def start_app
      UI.output
      UI.output 'Welcome to TicTacToe'
      UI.output 'Quick Game? (player vs computer : 3x3 board'
      settings unless UI.receive =~ /^y/i
      loop do 
        play 
        UI.output
        UI.output 'Play again?'
        break unless UI.receive =~ /^y/i
        UI.output
        UI.output 'Change settings?'
        settings if UI.receive =~ /^y/i
      end
      UI.output
      UI.output 'Thank you for playing.'
    end

    private
    def settings
      choose_player
      choose_board_size
    end

    def choose_player
      UI.output
      UI.output 'Choose Player : '
      UI.output '    p:     player'
      UI.output '    c:     computer'
      UI.output
      UI.output 'Player 1'
      @player_one = player_type(UI.receive)
      UI.output 'Player 2'
      @player_two = player_type(UI.receive)
      UI.output
    end

    def choose_board_size
      UI.output
      UI.output 'Enter Board Size :'
      UI.output '  3: 3x3'
      UI.output '  4: 4x4'
      UI.output '  N: NxN'
      size = UI.receive
      @board_size = (size.to_i >= 1) ? size : 3
      UI.output
    end

    def play
      GameManager.new(player_one, player_two, board_size).play
    end

    def player_one
      @player_one ||= HumanPlayer
    end

    def player_two
      @player_two ||= ComputerPlayer
    end

    def board_size
      @board_size ||= 3
    end

    def player_type(player)
      if player =~ /^p/i
        HumanPlayer
      elsif player =~ /^c/i
        ComputerPlayer
      else
        UI.output ' Invalid player type, please try again.'
        choose_player
      end
    end

  end
end
