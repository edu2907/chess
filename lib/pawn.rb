# frozen_string_literal: true

# The Pawn Piece in chess
class Pawn < Piece
  def initialize(color:, board:, pos:)
    super(color, board, pos)
    @initial_pos = pos
    @symbol = symbols(color)
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

  private

  def symbols(color)
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
