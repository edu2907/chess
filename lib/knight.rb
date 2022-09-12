# frozen_string_literal: true

# The Knight Piece in chess
class Knight < Piece
  def initialize(color:, board:, pos:)
    super(color, board, pos)
    @symbol = symbols(color)
    @notation_ltr = 'N'
  end

  def possible_moves
    possible_rows = [2, 1, -1, -2, -2, -1, 1, 2, 2]
    possible_cols = [1, 2, 2, 1, -1, -2, -2, -1, 1]

    col, row = @board.convert_to_indexes(pos)
    moves = []
    8.times do |i|
      move = "#{col + possible_cols[i]}#{row + possible_rows[i]}"
      moves.push(move) unless !move.match?(/^[0-7][0-7]$/) && ally?(move)
    end
    moves
  end

  def symbols(color)
    if color == 'white'
      '♘'
    else
      '♞'
    end
  end
end
