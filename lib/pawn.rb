# frozen_string_literal: true

# The Pawn Piece in chess
class Pawn < Piece
  def initialize(board, **piece_data)
    super(board, piece_data[:color], piece_data[:pos], piece_data[:has_moved])
    @symbol = symbols
    @notation_ltr = ''
  end

  def possible_moves
    col, row = pos
    direction = (color == 'white' ? -1 : 1)
    moves = []

    moves += pawn_pushes(col, row, direction)
    moves += pawn_captures(col, row, direction)

    moves.compact
  end

  def to_h
    super.merge({ has_moved: @has_moved })
  end

  private

  def symbols
    if color == 'white'
      '♙'
    else
      '♟'
    end
  end

  def pawn_pushes(col, row, direction)
    pushes = []
    push = [col, row + direction]
    db_push = [col, row + (2 * direction)]
    pushes << push if empty?(push)
    pushes << db_push if !@has_moved && empty?(db_push)
    pushes
  end

  def pawn_captures(col, row, direction)
    captures = []
    left = [col - 1, row + direction]
    right = [col + 1, row + direction]
    captures << left if valid_move?(left) && enemy?(left)
    captures << right if valid_move?(right) && enemy?(right)
    captures
  end
end
