# frozen_string_literal: true

# Group of attributes and behaviors shared between chess pieces. Should not be instatiated.
class Piece
  include NotationUtils

  attr_reader :color, :notation_ltr, :pos, :has_moved, :current_move_set

  def initialize(board, color_arg, pos, has_moved)
    @board = board
    @color = color_arg
    @has_moved = has_moved || false
    @pos = pos
  end

  def move(move_coord, move_notation)
    @board.remove_at(pos)
    @board.place_at(self, move_coord)
    @pos = move_coord
    @has_moved = true
    move_notation(move_notation)
  end

  # Verifies if the piece can perfom the move, considering the game status (like Check)
  def can_move?(move)
    current_move_set.include?(move)
  end

  def update_move_set
    @current_move_set = possible_moves
  end

  def possible_moves
    generate_moves
  end

  # Verifies if the piece can perfom the move, regardless of the game status (like Check)
  def piece_move?(move)
    generate_moves.include?(move)
  end

  def to_s
    @symbol
  end

  def to_h
    {
      notation_ltr:,
      has_moved:,
      color:
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
