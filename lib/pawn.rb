# frozen_string_literal: true

# The Pawn Piece in chess
class Pawn < Piece
  def initialize(color:, board:, pos:)
    super(color, board, pos)
    @symbol = symbols(color)
    @notation_ltr = ''
  end

  def symbols(color)
    if color == 'white'
      '♙'
    else
      '♟'
    end
  end
end
