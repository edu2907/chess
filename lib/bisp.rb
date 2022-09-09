# frozen_string_literal: true

# The Bisp Piece in chess
class Bisp < Piece
  def initialize(color:, board:, pos:)
    super(color, board, pos)
    @symbol = symbols
    @notation_ltr = 'B'
  end

  def symbols
    if color == 'white'
      '♗'
    else
      '♝'
    end
  end
end
