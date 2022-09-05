# frozen_string_literal: true

# The King Piece in chess
class King
  def initialize(color)
    @symbol = symbols(color)
  end

  def symbols(color)
    if color == 'white'
      '♔'
    else
      '♚'
    end
  end
end
