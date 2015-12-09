require 'spec_helper'
require_relative '../../cla/tic_tac_toe/human_player'

include TicTacToe

describe HumanPlayer do
  subject(:player) { HumanPlayer.new }
  let(:board) { Board.new }

  describe '#move' do
    it 'returns cell number' do
      allow(UI).to receive(:receive).and_return("5")
      expect( player.move ).to eq("5")
    end
  end

end
