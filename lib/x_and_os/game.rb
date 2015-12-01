class XAndOs::Game

  attr_reader :board

  def initialize(args)
    @board    = XAndOs::Board.new
  end

  def new_move(move, marker = get_marker)
    self if board.set_cell(cell, marker)
  end

  def get_marker
    (board.count_cells - free_cells).even? ? 'X' : 'O'
  end

  def winner?
    board.complete_rows.count >= 1
  end

  def draw?
    board.free_cells <= 0
  end

end

