# frozen_string_literal: true

# The Piece Piece in chess
class Pawn
  def initialize(color)
    @symbol = symbols(color)
  end

  def symbols(color)
    if color == 'white'
      '♙'
    else
      '♟'
    end
  end
end
