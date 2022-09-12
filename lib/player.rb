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

  def initialize(board, init_player_data)
    @board = board
    @color = init_player_data.color
    @name = create_name
    @mark_piece = mark_pieces
    place_pieces(init_player_data.main_row, init_player_data.pawn_row)
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

  def place_pieces(main_row, pawn_row)
    place_pawns(pawn_row)
    place_towers(main_row)
    place_knights(main_row)
    place_bisps(main_row)
    place_queen(main_row)
    place_king(main_row)
  end

  def move_piece
    piece = valid_piece?(input_start_coord) until piece
    initial_pos = piece.pos
    target = valid_target?(piece, input_target) until target
    return move_piece if target == 'back'

    @board.remove_at(initial_pos)
    @board.place_at(piece, target)
    "#{piece.notation_ltr + initial_pos} #{piece.notation_ltr + target}"
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

  private

  def input_start_coord
    puts 'Insert the coordinate of your selected piece: (Ex: a7)'
    gets.chomp
  end

  def input_target
    puts 'Insert the coordinate of your target: (or insert "back" to return)'
    gets.chomp
  end

  def place_pawns(pawn_row)
    @board.columns.each do |col|
      coord = "#{col}#{pawn_row}"
      @board.place_at(Pawn.new(color: @color, board: @board, pos: coord), coord)
    end
  end

  def place_towers(main_row)
    pos1 = "a#{main_row}"
    pos2 = "h#{main_row}"
    @board.place_at(Tower.new(color: @color, board: @board, pos: pos1), pos1)
    @board.place_at(Tower.new(color: @color, board: @board, pos: pos2), pos2)
  end

  def place_knights(main_row)
    pos1 = "b#{main_row}"
    pos2 = "g#{main_row}"
    @board.place_at(Knight.new(color: @color, board: @board, pos: pos1), pos1)
    @board.place_at(Knight.new(color: @color, board: @board, pos: pos2), pos2)
  end

  def place_bisps(main_row)
    pos1 = "c#{main_row}"
    pos2 = "f#{main_row}"
    @board.place_at(Bisp.new(color: @color, board: @board, pos: pos1), pos1)
    @board.place_at(Bisp.new(color: @color, board: @board, pos: pos2), pos2)
  end

  def place_queen(main_row)
    pos = "d#{main_row}"
    @board.place_at(Queen.new(color: @color, board: @board, pos: pos), pos)
  end

  def place_king(main_row)
    pos = "e#{main_row}"
    @board.place_at(King.new(color: @color, board: @board, pos: pos), pos)
  end
end
