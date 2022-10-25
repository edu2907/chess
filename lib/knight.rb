# frozen_string_literal: true

# The Knight Piece in chess
class Knight < Piece
  def initialize(board, **piece_data)
    super(board, piece_data[:color], piece_data[:pos], piece_data[:has_moved])
    @symbol = symbols
    @notation_ltr = 'N'
  end

  def generate_pseudo_moves
    possible_rows = [2, 1, -1, -2, -2, -1, 1, 2, 2]
    possible_cols = [1, 2, 2, 1, -1, -2, -2, -1, 1]

    col, row = pos
    moves = []
    8.times do |i|
      move = [col + possible_cols[i], row + possible_rows[i]]
      moves.push(move) unless !valid_move?(move) || ally?(move)
    end
    moves
  end

  private

  def symbols
    if color == 'white'
      '♘'
    else
      '♞'
    end
  end
end
