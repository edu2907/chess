# frozen_string_literal: true

# The Bisp Piece in chess
class Bisp < Piece
  def initialize(board, **piece_data)
    super(board, piece_data[:color], piece_data[:pos])
    @symbol = symbols
    @notation_ltr = 'B'
  end

  def possible_moves
    col, row = pos
    moves = []
    directions = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
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

  private

  def symbols
    if color == 'white'
      '♗'
    else
      '♝'
    end
  end
end
