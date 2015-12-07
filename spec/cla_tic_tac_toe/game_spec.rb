require 'spec_helper'
require_relative '../../cla/tic_tac_toe/game'

describe TicTacToe::Game do
  subject(:game) { TicTacToe::Game.new(HumanPlayer, ComputerPlayer) }

  it 'initializes with players' do
    expect(game.player1.name).to eq('HumanPlayer x')
    expect(game.player2.name).to eq('ComputerPlayer o')
  end

  describe '#current_player' do
    it 'returns player' do
      expect(game.current_player).to be_kind_of(HumanPlayer)
      expect(game.current_player.name).to eq('HumanPlayer x')
    end
  end
end
