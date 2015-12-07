require_relative './nameable'
module TicTacToe
  class HumanPlayer
    include Nameable
    
    attr_reader :board, :marker

    def initialize(args = {})
      @board  = args[:board]
      @marker = args[:marker]
    end

    def move(board)
      move = $stdin.gets.chomp
    end
  end
end
