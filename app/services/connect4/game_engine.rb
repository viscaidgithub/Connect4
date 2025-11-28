module Connect4
  module GameEngine
    ROWS = 6
    COLS = 7
    SIZE = ROWS * COLS

    def drop_piece(col)
      return false unless valid_move?(col)

      row = find_available_row(col)
      return false unless row

      place_piece(row, col)
      true
    end

    def reset!
      assign_attributes(
        board: Array.new(SIZE, ""),
        current_player: "R",
        status: "playing",
        winner: nil
      )
      save!
    end

    # helper to get cell at row,col
    def cell(row, col)
      board[index(row, col)]
    end

    private

      def ensure_board_and_defaults
        self.board = Array.new(SIZE, "") unless board.is_a?(Array) && board.length == SIZE
        self.current_player ||= "R"
        self.status ||= "playing"
      end

      def index(row, col)
        row * COLS + col
      end

      def switch_player
        self.current_player = (current_player == "R" ? "Y" : "R")
      end

      def valid_move?(col)
        status == "playing" && col.to_i.between?(0, COLS - 1)
      end

      def find_available_row(col)
        (ROWS - 1).downto(0).find { |row| board[index(row, col)].blank? }
      end

      def place_piece(row, col)
        board[index(row, col)] = current_player
        check_game_over_from(row, col)
        switch_player unless status == "won"
        save
      end

      def check_game_over_from(row, col)
        piece = board[index(row, col)]
        return if piece.blank?

        if winning_move?(row, col, piece)
          self.status = "won"
          self.winner = piece
        elsif board.none?(&:blank?)
          self.status = "draw"
        end
      end

      def winning_move?(row, col, piece)
        directions = [
          [0, 1],  # horizontal
          [1, 0],  # vertical
          [1, 1],  # diag down-right
          [1, -1]  # diag down-left
        ]

        directions.any? do |dr, dc|
          count_in_direction(row, col, dr, dc, piece) +
          count_in_direction(row, col, -dr, -dc, piece) - 1 >= 4
        end
      end

      def count_in_direction(row, col, dr, dc, piece)
        r, c = row, col
        count = 0

        while r.between?(0, ROWS - 1) &&
              c.between?(0, COLS - 1) &&
              board[index(r, c)] == piece

          count += 1
          r += dr
          c += dc
        end

        count
      end
  end
end
