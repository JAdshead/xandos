class XAndOs::Game

  attr_reader :board

  def initialize(args = {})
    rows = args[:rows] || 3
    columns = args[:columns] || 3
    @board = args[:board] || XAndOs::Board.new(rows,columns)
  end

  def add_move(cell, marker = get_marker)
    self if board.set_cell(cell, marker)
  end

  def get_marker
    (board.count_cells - board.free_cells.size).even? ? 'X' : 'O'
  end

  def winner?
    board.complete_rows.count >= 1
  end

  def draw?
    board.free_cells.size <= 0
  end

end

