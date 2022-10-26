# frozen_string_literal: true

# The King Piece in chess
class King < Piece
  attr_accessor :check_status

  def initialize(board, **piece_data)
    super(board, piece_data[:color], piece_data[:pos], piece_data[:has_moved])
    @symbol = symbols
    @notation_ltr = 'K'
    @check_status = piece_data[:check_status] || false
  end

  def generate_pseudo_moves
    possible_rows = [1, 1, 1, 0, 0, -1, -1, -1]
    possible_cols = [-1, 0, 1, -1, 1, -1, 0, 1]

    col, row = pos
    moves = []
    8.times do |i|
      move = [col + possible_cols[i], row + possible_rows[i]]
      moves.push(move) unless !valid_move?(move) || ally?(move)
    end
    moves
  end

  def update_check_status
    @check_status = check?
  end

  def check?
    enemies = @board.reject_by_keys(color:)
    enemies.any? { |enemy| enemy.move_set?(pos) }
  end

  private

  def symbols
    if color == 'white'
      '♔'
    else
      '♚'
    end
  end
end
