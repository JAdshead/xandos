class XAndOs::Board
  attr_reader :grid, :default_value, :rows, :columns

  def initialize(rows = 3, columns = 3, default_value = ' ')
    @grid          = new_grid(rows, columns, default_value)
    @default_value = default_value
    @rows          = rows
    @columns       = columns
  end

  def set_cell(cell_num, value)
    row, column = human_to_grid(cell_num)
    if grid[row][column] == default_value
      grid[row][column] = value
    else
      false
    end
  end

  def get_cell(cell_num)
    row, column = human_to_grid(cell_num)
    grid[row][column]
  end

  def diagonal_rows
    left_to_right = (0...rows).map { |i| grid[i][i] }
    right_to_left = (0...rows).map { |i| grid[i][columns - (i + 1)] }
    [left_to_right, right_to_left]
  end

  def vertical_rows
    grid.transpose
  end

  def horizontal_rows
    grid
  end

  def all_rows
    diagonal_rows + vertical_rows + horizontal_rows
  end

  def complete_rows
    all_rows.reject do |row|
      uniq_values = row.uniq
      uniq_values.include?(default_value) || uniq_values.count > 1
    end
  end

  def all_lines
    temp_board    = self.class.new(rows, columns)
    num_of_cells  = rows * columns

    (1..num_of_cells).each do |i|
      temp_board.set_cell(i,i)
    end

    temp_board.all_rows
  end

  def count_cells
    @total_cells ||= rows * columns
  end

  def find_cells value
    grid.flatten.map.with_index { |val, i| i + 1 if val == value }.compact
  end

  def free_cells
    find_cells default_value
  end

  def cell_locations
    store = Hash.new {|h,k| h[k] = [] }
    
    grid.flatten.map.with_index.inject(store) do |store, (cell, index)|
      if cell != default_value
        store[cell].push(index + 1)
      end
      store
    end
  end

  private

  def human_to_grid(cell_num)
    cell_num = cell_num.to_i - 1
    [row_number(cell_num), column_number(cell_num)]
  end

  def row_number(cell_num)
    cell_num / columns
  end

  def column_number(cell_num)
    cell_num - (row_number(cell_num) * columns)
  end

  def new_grid(rows, columns, cell_value)
    Array.new(rows) { Array.new(columns, cell_value) }
  end
end

