# frozen_string_literal: true

# The Knight Piece in chess
class Knight
  def initialize(color)
    @symbol = symbols(color)
  end

  def symbols(color)
    if color == 'white'
      '♘'
    else
      '♞'
    end
  end
end
