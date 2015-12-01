module XAndOs
  module GameMaster

    WINNING_LINES = [
      [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
    ]

    def best_move
      move = win || block || fork_move || force_block || block_fork
      return move if move

      if available_moves.size == total_cells
        1
      else
        center || corner || available_moves.sample
      end
    end

    protected

    def total_cells
      board.count_cells
    end

    def available_moves
      board.free_cells
    end

    def moves_made
      board.find_cells(marker)
    end

    def opponent_moves
      (1..9).to_a - (moves_made + available_moves)
    end

    def win
      wining_moves(moves_made).sample
    end

    def block
      wining_moves(opponent_moves).sample
    end

    def fork_move
      fork_moves(moves_made).sample
    end

    def force_block
      force_block_moves.sample
    end

    def block_fork
      fork_moves(opponent_moves).sample
    end

    def center
      5 if available_moves.include?(5)
    end

    def corner
      available_moves.select do |move|
        corner_moves.include?(move)
      end.sample
    end

    private

    def winning_lines
      @winning_lines ||= WINNING_LINES
    end

    def wining_moves(moves_made)
      winning_lines.map do |line|
        arr = line - moves_made

        next unless arr.size == 1

        available_moves.include?(arr.first) ? arr.first : nil
      end.compact
    end

    def fork_moves(moves_made, moves_left = available_moves)
      moves_left.map do |move|
        future_moves = moves_made.dup << move

        (wining_moves future_moves).size > 1 ? move : nil
      end.compact
    end

    def force_block_moves
      winning_lines.map do |line|
        next unless (line & opponent_moves).empty? && (line & moves_made).any?

        moves = line - moves_made

        safe_moves(moves, line)
      end.flatten.compact
    end

    def safe_moves(moves, line)
      moves.map do |move|
        forced_move = (line - (moves_made << move)).first

        opponent_future_moves = opponent_moves << forced_move

        wining_moves(opponent_future_moves).size < 2 ? move : nil
      end
    end

    def corner_moves
      # To be improved to dynamically work out corners
      # and move logic to board
      [1,3,7,9]
    end
  end

  end
end