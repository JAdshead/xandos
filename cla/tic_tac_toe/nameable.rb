module TicTacToe
  module Nameable
    attr_writer :name

    def name
      @name ||= name_creator
    end

    private

    def name_creator
      name = self.class.to_s.sub('TicTacToe::', '')
      name += " #{marker}" if marker
    end
  end
end
