# frozen_string_literal: true

# The Queen Piece in chess
class Queen < Piece
  protected

  def generate_pseudo_moves
    col, row = pos
    moves = []
    directions = [[1, 1], [1, -1], [-1, -1], [-1, 1], [1, 0], [-1, 0], [0, 1], [0, -1]]
    directions.each do |direction|
      c, r = direction
      loop do
        move = [col + c, row + r]
        break if !valid_move?(move) || ally?(move)

        moves << move
        break if enemy?(move)

        c += direction[0]
        r += direction[1]
      end
    end
    moves
  end

  def symbols
    if color == 'white'
      '♕'
    else
      '♛'
    end
  end

  def class_notation_ltr
    'Q'
  end
end
