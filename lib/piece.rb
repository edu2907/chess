# frozen_string_literal: true

# Group of attributes and behaviors shared between chess pieces. Should not be instatiated.
class Piece
  attr_accessor :pos
  attr_reader :color, :notation_ltr

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
  end

  def can_move_to?(target_coord)
    col, row = @board.convert_to_indexes(target_coord)
    target_indexes = "#{col}#{row}"

    possible_moves.include?(target_indexes)
  end

  def to_s
    @symbol
  end

  def to_h
    {
      piece_ltr: notation_ltr,
      piece_color: color,
      piece_pos: pos
    }
  end

  def enemy?(enemy_pos)
    enemy_piece = @board.at(enemy_pos)
    !enemy_piece.nil? && enemy_piece.color != color
  end

  def ally?(ally_pos)
    ally_piece = @board.at(ally_pos)
    !ally_piece.nil? && ally_piece.color == color
  end

  def empty?(pos)
    @board.at(pos).nil?
  end

  def valid_move?(move)
    move.match?(/^[0-7][0-7]$/)
  end
end
