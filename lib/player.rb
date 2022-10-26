# frozen_string_literal: true

# Represents the chess player, is responsible for managing the pieces
class Player
  include NotationUtils
  attr_reader :name, :color, :mark_piece

  def initialize(game, board:, color:, name:)
    @game = game
    @board = board
    @color = color
    @name = name || create_name
    @mark_piece = mark_pieces
    @king = find_king
  end

  def create_name
    puts "Hello, #{@color.capitalize} Player! Insert your name:"
    name = gets.chomp.capitalize
    name.match?(/\S/) ? name : @color.capitalize
  end

  def mark_pieces
    if @color == 'white'
      '♙'
    else
      '♟'
    end
  end

  def find_king
    king_keys = { color:, notation_ltr: 'K' }
    @board.select_by_keys(**king_keys).first
  end

  def check_message
    return unless @king.check_status

    '| In check!'
  end

  def execute_action
    loop do
      puts 'Perfom an action!'
      command = gets.chomp.split(' ')
      case command[0]
      when 'mv' then return mv(command[1], command[2]) || next
      when 'save' then return save
      else puts 'Invalid Option'
      end
    end
  end

  def to_h
    {
      color:,
      name:
    }
  end

  private

  def mv(first_arg, target)
    target ||= ''
    return puts 'No argument error! Dont forget to insert your move' if first_arg.nil?

    if notation?(first_arg) && notation?(target)
      move_piece(first_arg, target)
    elsif castling?(first_arg)
      castling(first_arg)
    else
      puts('Invalid move!')
    end
  end

  def move_piece(notation_pos, move_notation)
    piece = valid_piece?(notation_pos)
    return if piece.nil?

    move_coord = convert_to_coordinate(move_notation)
    if piece.can_move?(move_coord)
      piece.move(move_coord, move_notation)
    else
      puts "The selected piece cannot move to #{move_notation}!"
    end
  end

  def castling(castling_move)
    castling_move
  end

  def valid_piece?(piece_coord)
    piece_i = convert_to_coordinate(piece_coord)
    piece = @board.at(piece_i)
    if piece.nil? || @color != piece.color
      puts 'Selected piece error! There is no piece or the piece is from the enemy'
    else
      piece
    end
  end

  def save; end
end
