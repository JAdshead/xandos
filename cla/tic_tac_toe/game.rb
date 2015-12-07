require 'x_and_os'
require_relative './human_player'
require_relative './computer_player'
require_relative './display'

module TicTacToe
  class Game
    include Display

    attr_reader :player1, :player2, :board, :turns

    def initialize(player_1_class = HumanPlayer, player_2_class = ComputerPlayer)
      @game_manager = XAndOs::Game.new
      @player1  = player_1_class.new(marker: 'x')
      @player2  = player_2_class.new(marker: 'o')
      @turns    = 0
    end

    def current_player
      turns.even? ? player1 : player2
    end

    def last_player
      turns.odd? ? player1 : player2
    end

    def play
      print_intructions
      loop do
        if @game_manager.winner?
          Display.game_board(@game_manager.board.grid)
          puts "#{last_player.name} wins!!"
          break
        elsif @game_manager.draw?
          Display.game_board(@game_manager.board.grid)
          puts "It's a draw!!"
          break
        else
          move
        end
      end
    end

    def move
      player = current_player

      Display.game_board(@game_manager.board.grid)
      puts "#{player.name}'s turn."

      cell = player.move(@game_manager.board)

      until @game_manager.add_move(cell, player.marker)
        puts "\nSorry, invalid entry. Please try again\n\n"
        cell = cell = player.move(@game_manager.board)
      end

      @turns += 1
    end

    def print_intructions
      puts 'Choose a number between 1 and 9 to mark space in the grid'
      puts 'Place 3 marks in a horizontal, vertical, or diagonal row to win.'
      puts
    end

  end
end
