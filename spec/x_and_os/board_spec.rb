require 'spec_helper'
require_relative '../../lib/x_and_os/board'

include XAndOs

describe Board do
  subject(:board) { Board.new }
  let(:empty_grid) { [[' ',' ',' '],[' ', ' ',' '],[' ',' ',' ']] }
  # let(:populated_grid) { [['X','O','X'],['O','O','O'],['X','X','X']] }

  it 'initializes with 3x3 \' \' grid when no values given' do
    expect(board.grid).to eq(empty_grid)
  end

  it 'initializes with given rows and columns' do
    grid = [[' ', ' ', ' '],[' ',' ', ' ']]
    board = Board.new(2,3)
    expect(board.grid).to eq(grid)
  end

  describe '#set_cell' do
    it 'updates cell' do
      board.set_cell(3,'X')
      expect(board.grid[0][2]).to eq('X')
    end

    it 'does not write over existing value' do
      board.set_cell(3,'X')
      board.set_cell(3,'O')
      expect(board.grid[0][2]).to eq('X')
    end

    context 'on a 2x3 grid' do
      let(:board) { Board.new(2,3) }

      it 'updates cell' do
        board.set_cell(3,'X')
        expect(board.grid[0][2]).to eq('X')
      end
    end

    context 'on a 4x2 grid' do
      let(:board) { Board.new(4,2) }

      it 'updates cell' do
        (1..8).each do |i|
          board.set_cell(i,i)
        end

        expect(board.grid[0][1]).to eq(2)
        expect(board.grid[1][0]).to eq(3)
        expect(board.grid[1][1]).to eq(4)
        expect(board.grid[3][1]).to eq(8)
      end
    end

  end

  describe '#get_cell' do
    it 'returns cell value' do
      board.set_cell(3,'X')
      expect(board.get_cell(3)).to eq('X')
    end
  end

  describe 'getting rows with a 4x4 grid' do
    let(:board) { Board.new(4,4) }
    before(:each) do
      
      (1..16).each do |i|
        board.set_cell(i,i)
      end
    end

    describe '#diagonal_rows' do
      it 'returns diagonal values' do
        expect(board.diagonal_rows).to eq([[1,6,11,16],[4,7,10,13]])
      end
    end

    describe '#vertical_rows' do
      it 'returns column values' do
        expect(board.vertical_rows).to eq([[1,5,9,13],[2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16]])
      end
    end

    describe '#horizontal_rows' do
      it 'returns row values' do
        expect(board.horizontal_rows).to eq([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16]])
      end
    end
  end

  describe '#complete_rows' do
    board = Board.new
    before(:each) do
      (1..5).each do |i|
        board.set_cell(i,'x')
      end
    end

    it 'returns rows that have one uniq value' do
      expect(board.complete_rows).to eq([['x','x','x']])
    end
  end


  describe '#count_cells'do
    it 'returns correct number of cells in board' do
      expect(board.count_cells).to eq(9)
    end
  end

  describe '#find_cells' do
    before(:each) do
      (1..6).each do |i|
        board.set_cell(i,'x')
      end
    end

    it 'returns correct free cell numbers' do
      expect(board.find_cells(' ')).to eq([7,8,9])
    end

    it 'returns correct x filled cell numbers' do
      expect(board.find_cells('x')).to  eq([1,2,3,4,5,6])
    end
  end

  describe '#cell_locations' do 
    before(:each) do
      (1..5).each do |i|
        board.set_cell(i,'x')
      end

      (6..8).each do |i|
        board.set_cell(i,'o')
      end
    end

    it 'returns cells with locations' do
      expect(board.cell_locations).to eq({ 'x'=>[1,2,3,4,5], 'o'=>[6,7,8] })
    end
  end

  describe '#cell_lines' do
    it 'returns correct lines, including horizontal, diagonal and vertical' do
      board = Board.new(2,2)
      expect(board.all_lines.sort).to eq([[1, 2], [3, 4], [1,3], [2,4], [1,4], [2,3]].sort)
    end
  end
end
