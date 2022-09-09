class Piece
  attr_accessor :pos, :notation_ltr
  attr_reader :color

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    @symbol
  end

  def can_move_to?(target)
    true
  end
end
