# frozen_string_literal: true

# The Pawn Piece in chess
class Pawn < Piece
  def initialize(board, **piece_data)
    super(board, piece_data[:color], piece_data[:pos])
    @initial_pos = piece_data[:initial_pos]
    @symbol = symbols
    @notation_ltr = ''
  end

  def possible_moves
    col, row = @board.convert_to_indexes(pos)
    direction = (color == 'white' ? -1 : 1)
    moves = []

    moves += pawn_pushes(col, row, direction)
    moves += pawn_captures(col, row, direction)

    moves.compact
  end

  def to_h
    super.merge({ initial_pos: @initial_pos })
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
    push = "#{col}#{row + direction}"
    db_push = "#{col}#{row + (2 * direction)}"
    pushes << push if @board.at(push).nil?
    pushes << db_push if pos == @initial_pos && @board.at(db_push).nil?
    pushes
  end

  def pawn_captures(col, row, direction)
    captures = []
    left = "#{col - 1}#{row + direction}"
    right = "#{col + 1}#{row + direction}"
    captures << left if left.match?(/^[0-7][0-7]$/) && enemy?(left)
    captures << right if right.match?(/^[0-7][0-7]$/) && enemy?(right)
    captures
  end
end
