module XAndOs
  TEST='hi'
end

# class XAndOs::Board
#   attr_reader :grid, :default_value, :rows, :columns

#   def initialize(rows = 3, columns = 3, default_value = ' ')
#     @grid          = new_grid(rows, columns, default_value)
#     @default_value = default_value
#     @rows          = rows
#     @columns       = columns
#   end

#   def set_cell(cell_num, value)
#     row, column = human_to_grid(cell_num)
#     if grid[row][column] == default_value
#       grid[row][column] = value
#     else
#       false
#     end
#   end

#   def get_cell(cell_num)
#     row, column = human_to_grid(cell_num)
#     grid[row][column]
#   end

#   def diagonal_rows
#     left_to_right = (0...rows).map { |i| grid[i][i] }
#     right_to_left = (0...rows).map { |i| grid[i][rows - (i + 1)] }
#     [left_to_right, right_to_left]
#   end

#   def vertical_rows
#     grid.transpose
#   end

#   def horizontal_rows
#     grid
#   end

#   def all_rows
#     diagonal_rows + vertical_rows + horizontal_rows
#   end

#   def complete_rows
#     all_rows.reject do |row|
#       uniq_values = row.uniq
#       uniq_values.include?(default_value) || uniq_values.count > 1
#     end
#   end

#   def count_cells
#     @total_cells ||= rows * columns
#   end

#   def find_cells value
#     grid.flatten.map.with_index { |val, i| i + 1 if val == value }.compact
#   end

#   def free_cells
#     find_cells default_value
#   end

#   private

#   def human_to_grid(cell_num)
#     cell_num = cell_num.to_i - 1
#     [row_number(cell_num), column_number(cell_num)]
#   end

#   def row_number(cell_num)
#     cell_num / rows
#   end

#   def column_number(cell_num)
#     cell_num - (row_number(cell_num) * columns)
#   end

#   def new_grid(rows, columns, cell_value)
#     Array.new(rows) { Array.new(columns, cell_value) }
#   end
# end

