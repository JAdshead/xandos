require 'spec_helper'
require_relative '../../cla/tic_tac_toe/human_player'

include TicTacToe

describe HumanPlayer do
  subject(:player) { HumanPlayer.new }
  let(:board) { double("Board", :grid => [[' ',' '],[' ',' ']], :print => '', :count_cells => 9, :free_cells => "5")}

  describe '#move' do
    it 'returns cell number' do
      allow($stdin).to receive(:gets).and_return("5")
      expect( player.move(board) ).to eq("5")
    end
  end

end
