# frozen_string_literal: true

# The Knight Piece in chess
class Knight < Piece
  def initialize(color:, board:, pos:)
    super(color, board, pos)
    @symbol = symbols(color)
    @notation_ltr = 'N'
  end

  def symbols(color)
    if color == 'white'
      '♘'
    else
      '♞'
    end
  end
end
