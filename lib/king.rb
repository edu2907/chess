# frozen_string_literal: true

# The King Piece in chess
class King < Piece
  def initialize(color:, board:, pos:)
    super(color, board, pos)
    @symbol = symbols(color)
    @notation_ltr = 'K'
  end

  def symbols(color)
    if color == 'white'
      '♔'
    else
      '♚'
    end
  end
end
