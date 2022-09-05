# frozen_string_literal: true

require_relative 'pawn'
require_relative 'tower'
require_relative 'bisp'
require_relative 'knight'
require_relative 'queen'
require_relative 'king'

# Represents the chess player, is responsible for managing the pieces
class Player
  def initialize(board, init_player_data)
    @board = board
    @color = init_player_data.color
    @name = create_name
    @main_row = init_player_data.main_row
    @pawn_row = init_player_data.pawn_row
    place_pieces
  end

  def create_name
    puts "Hello, #{@color.capitalize} Player! Insert your name:"
    gets.chomp
  end

  def place_pieces
    place_pawns
    place_towers
    place_knights
    place_bisps
    place_queen
    place_king
  end

  def place_pawns
    @board.columns.each do |col|
      coord = "#{col}#{@pawn_row}"
      @board.place_at(Pawn.new(@color), coord)
    end
  end

  def place_towers
    pos1 = "A#{@main_row}"
    pos2 = "H#{@main_row}"
    @board.place_at(Tower.new(@color), pos1)
    @board.place_at(Tower.new(@color), pos2)
  end

  def place_knights
    pos1 = "B#{@main_row}"
    pos2 = "G#{@main_row}"
    @board.place_at(Knight.new(@color), pos1)
    @board.place_at(Knight.new(@color), pos2)
  end

  def place_bisps
    pos1 = "C#{@main_row}"
    pos2 = "F#{@main_row}"
    @board.place_at(Bisp.new(@color), pos1)
    @board.place_at(Bisp.new(@color), pos2)
  end

  def place_queen
    pos = "D#{@main_row}"
    @board.place_at(Queen.new(@color), pos)
  end

  def place_king
    pos = "E#{@main_row}"
    @board.place_at(King.new(@color), pos)
  end
end
