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

  def possible_moves
    col, row = @board.convert_to_indexes(pos)
    moves = []
    directions = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
    directions.each do |direction|
      c, r = direction
      loop do
        move = "#{col + c}#{row + r}"
        break if !move.match?(/^[0-7][0-7]$/) || ally?(move)
  
        moves << move
        break if enemy?(move)
        c += direction[0]
        r += direction[1]
      end
    end
    moves
  end
end
