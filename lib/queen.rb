# frozen_string_literal: true

# The Queen Piece in chess
class Queen < Piece
  def initialize(board, **piece_data)
    super(board, piece_data[:color], piece_data[:pos])
    @symbol = symbols
    @notation_ltr = 'Q'
  end

  def possible_moves
    col, row = @board.convert_to_indexes(pos)
    moves = []
    directions = [[1, 1], [1, -1], [-1, -1], [-1, 1], [1, 0], [-1, 0], [0, 1], [0, -1]]
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

  private

  def symbols
    if color == 'white'
      '♕'
    else
      '♛'
    end
  end
end
