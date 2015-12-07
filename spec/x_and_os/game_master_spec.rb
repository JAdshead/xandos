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
    it 'returns value for cell' do
      expect( game_master.best_move(board: board) ).to be_between(1, 9)
    end

    it 'does not return a value for taken cell' do
      (1..8).each do |i|
        board.set_cell(i,'x')
      end

      expect( game_master.best_move(board: board) ).to eq(9)
    end

    describe 'can win' do
      context '3x3 grid' do
        it 'has killer instict' do
          allow(board).to receive(:grid) {[['x','x',' '],
                                           [' ',' ','o'],
                                           ['o',' ','o']]}

          # run move 6times to minimize chance causing pass
          results = []
          6.times { results << game_master.best_move(board: board) }

          expect(results).to eq([3,3,3,3,3,3])
        end
      end

      context '4x4 grid' do
        let(:board) { Board.new(4,4) }
        it 'has killer instict' do
          allow(board).to receive(:grid) {[['x','x',' ',' '],
                                           [' ','x','o',' '],
                                           ['o',' ',' ',' '],
                                           ['o',' ',' ','x']]}

          # run move 6times to minimize chance causing pass
          results = []
          6.times { results << game_master.best_move(board: board) }

          expect(results).to eq([11,11,11,11,11,11])
        end
      end
    end
    
    
    describe 'needs to defend' do
      it 'will block vertically 3x2' do
        allow(board).to receive(:grid) {[['x',' ', ' '],
                                         [' ','o', ' ']]}
        results = []
        6.times { results << game_master.best_move(marker: 'o') }
        expect(results).to eq([4,4,4,4,4,4])
      end

      it 'will block diagonally 3x3' do
        allow(board).to receive(:grid) {[['x',' ','o'],
                                         [' ','x',' '],
                                         [' ',' ',' ']]}
        results = []
        6.times { results << game_master.best_move(marker: 'o') }
        expect(results).to eq([9,9,9,9,9,9])
      end

      it 'will block horizonally 4x4' do
        board = Board.new(4,4)
        allow(board).to receive(:grid) {[[' ',' ','o','x'],
                                         ['x',' ','x','x'],
                                         [' ',' ','o',' '],
                                         [' ','o',' ',' ']]}
        results = []
        6.times { results << game_master.best_move(board: board, marker: 'o') }
        expect(results).to eq([6,6,6,6,6,6])
      end
    end
    
    describe 'can fork (create more that one oppotunity to win)' do
      context '3x3' do
        it 'it will fork' do
          allow(board).to receive(:grid) {[[' ','o',' '],
                                           [' ','o','x'],
                                           [' ','x',' ']]}

          results = []
          6.times { results << game_master.best_move }

          expect(results).to eq([9,9,9,9,9,9])
        end
      end

      context '4x4' do
        let(:board) { Board.new(4,4) }
        it 'it will fork' do
          allow(board).to receive(:grid) {[[' ','o',' ',' '],
                                           ['o','o','x',' '],
                                           ['o','o','x',' '],
                                           [' ','x',' ','x']]}

          results = []
          6.times { results << game_master.best_move }

          expect(results).to eq([15,15,15,15,15,15])
        end
      end
    end

    describe 'force block' do
      it 'forces opponent to block, block does not create forking move' do
        allow(board).to receive(:grid) {[['x',' ',' '],
                                         [' ','o',' '],
                                         [' ',' ','x']]}

        results = []
        6.times { results << game_master.best_move(marker: 'o') }

        expect(results).not_to include(3,7)
      end
    end

    describe 'needs to block fork' do
      it 'it blocks fork' do
        allow(board).to receive(:grid) {[['x',' ',' '],
                                         [' ',' ','x'],
                                         [' ',' ',' ']]}

        results = []
        6.times { results << game_master.best_move(marker: 'o') }
        expect(results).not_to include(1,2,6,7,8)
      end
    end
    
    describe 'center is free' do
      context '3x3' do
        it 'it will choose center' do
          allow(board).to receive(:free_cells).and_return( [1,2,4,5,6,7,8,9],[1,3,4,5,6,7,8,9],[1,2,3,4,5,7,8,9] )

          results = []
          6.times { results << game_master.best_move(marker: 'o') }

          expect(results).to eq([5,5,5,5,5,5])
        end
      end

      context '5x5' do
        let(:board) { Board.new(5,5) }

        it 'it will get close as possible to center' do
          allow(board).to receive(:free_cells).and_return([1,2] + (4..25).to_a)

          results = []
          6.times { results << game_master.best_move(marker: 'o') }

          expect(results).to eq([13,13,13,13,13,13])
        end
      end
      
    end

    describe 'first move' do
      it 'will pick corner' do
        expect(game_master.best_move).to be(1)
      end
    end
    
    describe 'center is taken' do
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