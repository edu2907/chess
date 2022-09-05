# frozen_string_literal: true

# The Queen Piece in chess
class Queen
  def initialize(color)
    @symbol = symbols(color)
  end

  def symbols(color)
    if color == 'white'
      '♕'
    else
      '♛'
    end
  end
end
