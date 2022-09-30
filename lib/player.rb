# frozen_string_literal: true

require_relative 'piece'
require_relative 'pawn'
require_relative 'tower'
require_relative 'bisp'
require_relative 'knight'
require_relative 'queen'
require_relative 'king'

# Represents the chess player, is responsible for managing the pieces
class Player
  attr_reader :name, :mark_piece

  def initialize(board:, color:, name:)
    @board = board
    @color = color
    @name = name || create_name
    @mark_piece = mark_pieces
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

  def move_piece
    piece = valid_piece?(input_start_coord) until piece
    initial_pos = piece.pos
    target = valid_target?(piece, input_target) until target
    return move_piece if target == 'back'

    @board.remove_at(initial_pos)
    @board.place_at(piece, target)
    move_notation(piece, target)
  end

  def valid_piece?(piece_coord)
    piece = @board.at(piece_coord)
    if !piece_coord.match?(/^[a-h][1-8]$/)
      puts 'Invalid input!'
    elsif piece.nil? || @color != piece.color
      puts 'Invalid piece!'
    else
      piece
    end
  end

  def valid_target?(piece, target)
    return target if target == 'back'

    if !target.match?(/^[a-h][1-8]$/)
      puts 'Invalid input!'
    elsif !piece.can_move_to?(target)
      puts 'Invalid target!'
    else
      target
    end
  end

  def move_notation(piece, move)
    piece.notation_ltr + move
  end

  def to_h
    {
      color: @color,
      name:
    }
  end

  private

  def input_start_coord
    puts 'Insert the coordinate of your selected piece: (Ex: a7)'
    gets.chomp
  end

  def input_target
    puts 'Insert the coordinate of your target: (or insert "back" to return)'
    gets.chomp
  end
end
