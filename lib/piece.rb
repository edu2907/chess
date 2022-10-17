# frozen_string_literal: true

# Group of attributes and behaviors shared between chess pieces. Should not be instatiated.
class Piece
  attr_accessor :pos
  attr_reader :color, :notation_ltr

  def initialize(board, color_arg, pos, has_moved)
    @board = board
    @color = color_arg
    @has_moved = has_moved || false
    @pos = pos
  end

  def move(move, notation)
    @board.remove_at(pos)
    @board.place_at(self, move)
    @pos = move
    @has_moved = true
    move_notation(notation)
  end

  def can_move?(move)
    possible_moves.include?(move)
  end

  def to_s
    @symbol
  end

  def to_h
    {
      piece_ltr: notation_ltr,
      color:,
      has_moved: @has_moved
    }
  end

  def move_notation(move)
    notation_ltr + move
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
    move.all? { |index| (0..7).include?(index) }
  end
end
