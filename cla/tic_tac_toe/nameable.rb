module TicTacToe
  module Nameable
    attr_writer :name

    def name
      @name ||= self.class.to_s.sub('TicTacToe::', '')
    end
  end
end
