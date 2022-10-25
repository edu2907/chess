# frozen_string_literal: true

# Group of attributes and behaviors shared between chess pieces. Should not be instatiated.
class Piece
  include NotationUtils

  attr_reader :color, :notation_ltr, :pos, :has_moved

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

  # Pseudo Legal Moves are moves that a piece can perfom, regardless of the game status (like Check)
  # Legal Moves Moves are moves that a piece can perfom, considering the game status (like Check)

  def update_pseudo_moves
    @current_pseudo_moves = generate_pseudo_moves
  end

  def update_legal_moves
    @current_legal_moves = generate_legal_moves
  end

  def move_set?(move)
    @current_pseudo_moves.include?(move)
  end

  def can_move?(move)
    @current_legal_moves.include?(move)
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

  protected

  def generate_legal_moves
    @current_pseudo_moves
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
