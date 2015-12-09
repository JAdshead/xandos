require 'spec_helper'
require_relative '../../cla/tic_tac_toe/game_manager'

include TicTacToe

describe GameManager do
  subject(:gm) { GameManager.new(HumanPlayer, ComputerPlayer) }

  it 'initializes with players and board size' do
    gm = GameManager.new(HumanPlayer, ComputerPlayer, 4)

    expect(gm.player1.name).to eq('HumanPlayer x')
    expect(gm.player2.name).to eq('ComputerPlayer o')

    expect(gm.board.rows).to eq(4)
  end

  describe '#current_player' do
    it 'returns player' do
      expect(gm.current_player).to be_kind_of(HumanPlayer)
      expect(gm.current_player.name).to eq('HumanPlayer x')
    end
  end
end
