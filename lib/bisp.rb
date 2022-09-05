# frozen_string_literal: true

# The Bisp Piece in chess
class Bisp
  def initialize(color)
    @symbol = symbols(color)
  end

  def symbols(color)
    if color == 'white'
      '♗'
    else
      '♝'
    end
  end
end
