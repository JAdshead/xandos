module TicTacToe
  module Display

    def self.game_board(board)
      total_rows = board.length

      puts

      board.each_with_index do |row, row_index|
        row_with_move_numbers = blank_cells_to_numbers(row, row_index)

        puts "\t " + row_with_move_numbers.flatten.join(' | ')
        puts "\t --+---+--" unless row_index + 1 >= total_rows
      end

      puts
    end

 
    private

    def self.blank_cells_to_numbers(row, row_index)
      previous_cells_count = row.length * row_index

      row.map.with_index do |cell, column_index|
        column_number = column_index + 1
        not_blank(cell) ? cell : previous_cells_count + column_number
      end
    end

    def self.not_blank(str)
      /\S+/ =~ str.to_s
    end

  end
end
