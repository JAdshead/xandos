require 'spec_helper'
require_relative '../../lib/x_and_os/game_master'
require_relative '../../lib/x_and_os/board'

include XAndOs

describe GameMaster do
  subject(:game_master) { GameMaster.new(marker: 'x', board: board) }
  let(:board) { Board.new }

  describe '#winning_lines' do
    it 'returns correct winning lines on 3x3 board' do
      winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

      expect(game_master.winning_lines.sort).to eq(winning_lines.sort)
    end

    it 'returns correct winning lines on 2x2 board' do
      board = Board.new(2,2)
      game_master = GameMaster.new(marker: 'x', board: board)

      winning_lines = [[1, 2], [3, 4], [1,3], [2,4], [1,4], [2,3]]

      expect(game_master.winning_lines.sort).to eq(winning_lines.sort)
    end
  end

  describe '#best_move' do
    context 'with standard 3x3 grid' do
      
      it 'returns value for cell' do
        expect( game_master.best_move(board: board) ).to be_between(1, 9)
      end

      it 'does not return a value for taken cell' do
        (1..8).each do |i|
          board.set_cell(i,'x')
        end

        expect( game_master.best_move(board: board) ).to eq(9)
      end

      it 'has killer instict' do
        allow(board).to receive(:grid) {[['x',' ','x'],
                                         [' ',' ','o'],
                                         ['o',' ',' ']]}

        # run move 6times to minimize chance causing pass
        results = []
        6.times { results << game_master.best_move(board: board) }

        expect(results).to eq([2,2,2,2,2,2])
      end

      it 'will defend vertically' do
        allow(board).to receive(:grid) {[['x',' ',' '],
                                         [' ',' ',' '],
                                         ['x','o',' ']]}
        results = []
        6.times { results << game_master.best_move(marker: 'o') }
        expect(results).to eq([4,4,4,4,4,4])
      end

      it 'will defend / block horizontaly' do
        allow(board).to receive(:grid) {[['x',' ','o'],
                                         [' ','x',' '],
                                         [' ',' ',' ']]}
        results = []
        6.times { results << game_master.best_move(marker: 'o') }
        expect(results).to eq([9,9,9,9,9,9])
      end

      it 'it will fork - create two oppotunities to win' do

        allow(board).to receive(:grid) {[[' ','o',' '],
                                         [' ','o','x'],
                                         [' ','x',' ']]}

        results = []
        6.times { results << game_master.best_move }

        expect(results).to eq([9,9,9,9,9,9])
      end

      it 'forces opponent to block, block does not create forking move' do
        allow(board).to receive(:grid) {[['x',' ',' '],
                                         [' ','o',' '],
                                         [' ',' ','x']]}

        results = []
        6.times { results << game_master.best_move(marker: 'o') }

        expect(results).not_to include(3,7)
      end

      it 'it blocks fork' do
        allow(board).to receive(:grid) {[['x',' ',' '],
                                         [' ',' ','x'],
                                         [' ',' ',' ']]}

        results = []
        6.times { results << game_master.best_move(marker: 'o') }
        expect(results).not_to include(1,2,6,7,8)
      end

      it 'it will choose center' do
        allow(board).to receive(:free_cells).and_return( [1,2,4,5,6,7,8,9],[1,3,4,5,6,7,8,9],[1,2,3,4,5,7,8,9] )

        results = []
        6.times { results << game_master.best_move(marker: 'o') }

        expect(results).to eq([5,5,5,5,5,5])
      end

      it 'will pick corner if first move' do
        expect(game_master.best_move).to be(1)
      end

      it 'will pick corner when other moves cant be made' do
        allow(board).to receive(:grid) {[[' ',' ',' '],
                                         [' ','x',' '],
                                         [' ',' ',' ']]}

        results = []
        6.times { results << game_master.best_move(marker: 'o') }

        expect(results).not_to include(2,4,6,8,5)
        expect(results).to all(be_an(Integer))
      end
    end
  end
end