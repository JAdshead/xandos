require 'x_and_os'
require_relative './nameable'

module TicTacToe
  class ComputerPlayer
    include Nameable

    attr_reader :board, :marker

    def initialize(args)
      @board  = args[:board]
      @marker = args[:marker]
      @game_master = XAndOs::GameMaster.new(board: board, marker: marker)
    end
    
    def move(board)
      @game_master.best_move 
    end
  end
end

