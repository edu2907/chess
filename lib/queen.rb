# frozen_string_literal: true

# The Queen Piece in chess
class Queen < Piece
  def initialize(color:, board:, pos:)
    super(color, board, pos)
    @symbol = symbols(color)
    @notation_ltr = 'Q'
  end

  def symbols(color)
    if color == 'white'
      '♕'
    else
      '♛'
    end
  end
end
