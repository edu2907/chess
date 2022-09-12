class Piece
  attr_accessor :pos, :notation_ltr
  attr_reader :color

  def initialize(color, board, pos)
    @color = color
    @board = board
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

  def enemy?(enemy_pos)
    enemy_piece = @board.at(enemy_pos)
    !enemy_piece.nil? && enemy_piece.color != color
  end

  def ally?(ally_pos)
    ally_piece = @board.at(ally_pos)
    !ally_piece.nil? && ally_piece.color == color
  end
end
