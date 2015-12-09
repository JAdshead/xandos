require_relative './nameable'
require_relative './ui'

module TicTacToe
  class HumanPlayer
    include Nameable
    
    attr_reader :board, :marker

    def initialize(args = {})
      @board  = args[:board]
      @marker = args[:marker]
    end

    def move
      move = UI.receive
    end
  end
end
