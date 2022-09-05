# frozen_string_literal: true

# The Tower Piece in chess
class Tower
  def initialize(color)
    @symbol = symbols(color)
  end

  def symbols(color)
    if color == 'white'
      '♖'
    else
      '♜'
    end
  end
end
