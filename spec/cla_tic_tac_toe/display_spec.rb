require 'spec_helper'
require_relative '../../cla/tic_tac_toe/display'

include TicTacToe

describe Display do

  describe '#game_board' do
    it 'prints to STDOUT' do
      expect(STDOUT).to receive(:puts).exactly(7).times
      Display.game_board([[1,2,3],[4,5,6],[7,8,9]])
    end

    context 'with a 5x5 (non default) grid' do
      
      it 'prints to STDOUT' do
        expect(STDOUT).to receive(:puts).exactly(11).times
        Display.game_board([[1,2,3,4,5],[1,2,3,4,5],[1,2,3,4,5],[1,2,3,4,5],[1,2,3,4,5]])
      end
    end
  end

end