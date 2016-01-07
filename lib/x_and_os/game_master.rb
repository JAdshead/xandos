module XAndOs
  class GameMaster
    attr_reader :board, :marker
    def initialize(args = {})
      @board      = args[:board]
      @marker     = args[:marker]
      @move_args  = {}
    end

    def best_move(args={})
      @move_args = args
      move = win || block || fork_move || force_block || block_fork
      return move if move

      if first_move?
        1
      else
        center || corner || available_moves.sample
      end
    end

    def winning_lines
      @winning_lines ||= build_winning_lines
    end
    
    private

    def mastery_board
      @mastery_board  = @move_args[:board]  || board
    end

    def current_marker
      @current_marker = @move_args[:marker] || marker
    end

    def build_winning_lines
      mastery_board.all_lines
    end

    def total_cells
      mastery_board.count_cells
    end

    def available_moves
      mastery_board.free_cells
    end

    def moves_made
      mastery_board.find_cells(current_marker)
    end

    def opponent_moves
      (1..total_cells).to_a - (moves_made + available_moves)
    end

    def first_move?
      available_moves.size == total_cells
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
      # no center move for even numbered total cells
      if mastery_board.count_cells.odd?
        center_cell = (mastery_board.count_cells + 1) / 2
        center_cell if available_moves.include?(center_cell)
      end
    end

    def corner
      available_moves.select do |move|
        corner_moves.include?(move)
      end.sample
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
      # [1,3,7,9]
      corner_moves = [1]
      total_columns = mastery_board.columns
      corner_moves << total_columns
      corner_moves << (total_cells - total_columns) + 1
      corner_moves << total_cells
    end
    
  end
end