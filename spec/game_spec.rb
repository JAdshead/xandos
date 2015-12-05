require 'spec_helper'
require_relative '../lib/x_and_os/game'
require_relative '../lib/x_and_os/board'

include XAndOs

describe Game do
  subject(:game) { Game.new }

  describe '#initialize ' do
    it 'initializes with game board' do
      expect(game.board.class).to eq(Board)
    end

    it 'can set a game board' do
      fakeboard = Struct.new('Board').new
      game = Game.new(board: fakeboard)

      expect(game.board).to be(fakeboard)
    end
  end

  describe '#add_move' do
    it 'updates the board' do 
      game.add_move(3, 'x')
      expect(game.board.grid).to eq([[' ',' ','x'],
                                     [' ',' ',' '],
                                     [' ',' ',' ']])
      game.add_move(5, 'o')
      expect(game.board.grid).to eq([[' ',' ','x'],
                                     [' ','o',' '],
                                     [' ',' ',' ']])
    end

    it 'does not overide existing value' do 
       game.add_move(3, 'x')
       game.add_move(3, 'o')
       expect(game.board.grid).to eq([[' ',' ','x'],
                                     [' ',' ',' '],
                                     [' ',' ',' ']])
    end
  end

  describe '#get_marker' do
    it 'returns marker' do
      game.add_move(3, 'X')
      expect(game.get_marker).to eq('O')

      game.add_move(2, 'O')
      expect(game.get_marker).to eq('X')
    end
  end

  describe '#winner?' do
    it 'returns false when new game' do
      expect(game.winner?).to be(false)
    end

    it 'returns true when three in a row' do
      game.add_move(1,'x')
      game.add_move(2,'x')
      game.add_move(3,'x')

      expect(game.winner?).to be(true)
    end
  end

  describe '#draw?' do
    it 'returns false when new game' do
      expect(game.draw?).to be(false)
    end

    it 'returns true when no moves left' do 
      (1..9).each do |n|
        game.add_move(n,n)
      end
      expect(game.draw?).to be(true)
    end
  end
end
