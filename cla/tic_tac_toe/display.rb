module TicTacToe
  module Display

    def self.game_board(board)
      height    = board.length
      width     = board.first.length
      padding   = (width * height).to_s.length
      
      puts
      board.each_with_index do |row, row_index|
        row_with_move_numbers = blank_cells_to_numbers(row, row_index)
        
        padded_row = add_padding_to_row(row_with_move_numbers, padding)

        puts "\t " + padded_row.join(' | ')
        puts  divider(width, padding) unless row_index + 1 >= height
      end

      puts
    end

 
    private

    def self.divider(width, padding)
      dividers = []
      width.times do
        dividers << ('-' * padding)
      end

      "\t #{dividers.join('-+-')}"
    end

    def self.add_padding_to_row(row, padding)
      row.map do |cell|
        format_string = "%-#{padding}s"
        format_string % cell.to_s
      end
    end

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
