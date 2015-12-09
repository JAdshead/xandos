require 'x_and_os'
require_relative './human_player'
require_relative './computer_player'
require_relative './display'
require_relative './ui'

module TicTacToe
  class GameManager
    include Display

    attr_reader :player1, :player2, :turns

    def initialize(player_1_class = HumanPlayer, player_2_class = ComputerPlayer, board_size = 3)
      @game = XAndOs::Game.new(rows: board_size, columns: board_size)
      @player1  = player_1_class.new(marker: 'x', board: board)
      @player2  = player_2_class.new(marker: 'o', board: board)
      @turns    = 0
    end

    def current_player
      turns.even? ? player1 : player2
    end

    def last_player
      turns.odd? ? player1 : player2
    end

    def board
      @game.board
    end

    def play
      print_intructions
      loop do
        if @game.winner?
          Display.game_board(board.grid)
          UI.output "#{last_player.name} wins!!"
          break
        elsif @game.draw?
          Display.game_board(board.grid)
          UI.output "It's a draw!!"
          break
        else
          move
        end
      end
    end

    def move
      player = current_player

      Display.game_board(board.grid)
      UI.output "#{player.name}'s turn."

      cell = player.move

      until @game.add_move(cell, player.marker)
        UI.output "\nSorry, invalid entry. Please try again\n\n"
        cell = player.move
      end

      @turns += 1
    end

    def print_intructions
      UI.output 'Choose a number between 1 and 9 to mark space in the grid'
      UI.output 'Place 3 marks in a horizontal, vertical, or diagonal row to win.'
      UI.output
    end

  end
end
