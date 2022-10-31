# frozen_string_literal: true

# Abstract class that represents a generic chess piece.
class Piece
  attr_reader :color, :notation_ltr, :pos, :has_moved

  def initialize(board, **piece_data)
    @board = board
    @color = piece_data[:color]
    @has_moved = piece_data[:has_moved] || false
    @pos = piece_data[:pos]
    @symbol = symbols
    @notation_ltr = class_notation_ltr
    post_initialize(piece_data)
  end

  def post_initialize(piece_data); end

  def class_notation_ltr
    raise NotImplementedError, "Missing #class_notation_ltr method for #{self.class.name}"
  end

  def symbols
    raise NotImplementedError, "Missing #symbols method for #{self.class.name}"
  end

  def move(move_coord)
    @board.remove_at(pos)
    @board.place_at(self, move_coord)
    @pos = move_coord
    @has_moved = true
  end

  # Pseudo Legal Moves are moves that a piece can perfom, regardless of the game status (like Check)
  # Legal Moves Moves are moves that a piece can perfom, considering the game status (like Check)

  def update_pseudo_moves
    @current_pseudo_moves = generate_pseudo_moves
  end

  def update_legal_moves
    @current_legal_moves = generate_legal_moves
  end

  def pseudo_move?(move)
    @current_pseudo_moves.include?(move)
  end

  def legal_move?(move)
    @current_legal_moves.include?(move)
  end

  def can_move?
    !@current_legal_moves.empty?
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
    @current_pseudo_moves.reject do |move|
      board_clone = clone_board
      board_clone.at(pos).move(move)
      enemy_pieces = board_clone.reject_by_keys(color:)
      enemy_pieces.each(&:update_pseudo_moves)
      king = board_clone.select_by_keys(color:, notation_ltr: 'K').first
      king.check?
    end
  end

  def clone_board
    Board.new(@board.to_arr)
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
