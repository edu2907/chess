# frozen_string_literal: true

# The Pawn Piece in chess
class Pawn < Piece
  def promote
    return unless can_promote?

    promoted_piece = create_promoted_piece(input_promotion)
    @board.place_at(promoted_piece, pos)
    # NOTE: Required to calculate legal moves
    # promoted_piece.update_pseudo_moves
  end

  protected

  def generate_pseudo_moves
    col, row = pos
    direction = (color == 'white' ? -1 : 1)
    moves = []

    moves += pawn_pushes(col, row, direction)
    moves += pawn_captures(col, row, direction)

    moves.compact
  end

  def symbols
    if color == 'white'
      '♙'
    else
      '♟'
    end
  end

  def class_notation_ltr
    ''
  end

  private

  def can_promote?
    promotion_row = color == 'white' ? 0 : 7
    pos[1] == promotion_row
  end

  def input_promotion
    promotion_options = ['Q', 'N', 'B', 'R', '']
    loop do
      puts "The pawn at #{pos} can be promoted! Select the piece you wish to promote: (default=Q)"
      selected_option = gets.chomp
      return selected_option if promotion_options.include?(selected_option)

      puts 'Invalid option! Valid options: Q (Queen), N (Knight), B (Bishop), R (Rook)'
    end
  end

  def create_promoted_piece(promotion_option)
    case promotion_option
    when 'N' then Knight.new(@board, color:, pos:)
    when 'B' then Bisp.new(@board, color:, pos:)
    when 'R' then Rook.new(@board, color:, pos:)
    else Queen.new(@board, color:, pos:)
    end
  end

  def pawn_pushes(col, row, direction)
    pushes = []
    push = [col, row + direction]
    db_push = [col, row + (2 * direction)]
    pushes << push if empty?(push)
    pushes << db_push if !@has_moved && empty?(db_push)
    pushes
  end

  def pawn_captures(col, row, direction)
    captures = []
    left = [col - 1, row + direction]
    right = [col + 1, row + direction]
    captures << left if valid_move?(left) && enemy?(left)
    captures << right if valid_move?(right) && enemy?(right)
    captures
  end
end
