# frozen_string_literal: true

# The Tower Piece in chess
class Tower < Piece
  def initialize(color:, board:, pos:)
    super(color, board, pos)
    @symbol = symbols(color)
    @notation_ltr = 'R'
  end

  def symbols(color)
    if color == 'white'
      '♖'
    else
      '♜'
    end
  end
end
