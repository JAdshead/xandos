require 'x_and_os'
require_relative './nameable'

module TicTacToe
  class ComputerPlayer
    include XAndOs::GameMastery
    include Nameable

    attr_reader :board, :marker

    def initialize(args)
      @board  = args[:board]
      @marker = args[:marker]
    end
    
    def move(board)
      best_move(board: board)
    end
  end
end

