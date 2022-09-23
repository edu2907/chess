# frozen_string_literal: true

require 'colorize'

# Is a chess board
class Board
  attr_reader :columns, :arr

  def initialize
    @arr = Array.new(8) { Array.new(8) }
    @columns = %w[a b c d e f g h]
  end

  # Accepts values as a coordinate ("A2") or indexes string
  def at(pos)
    is_coordinate = lambda { |str| str.match?(/^[a-h][1-8]$/) }
    is_indexes = lambda { |str| str.match?(/^[0-7][0-7]$/) }

    case pos
    when is_coordinate
      row = convert_to_row_index(pos[1])
      col = convert_to_col_index(pos[0])
    when is_indexes
      row = pos[1].to_i
      col = pos[0].to_i
    else return
    end

    arr[row][col]
  end

  def remove_at(coord)
    col = convert_to_col_index(coord[0])
    row = convert_to_row_index(coord[1])
    arr[row][col].pos = nil
    arr[row][col] = nil
  end

  def place_at(piece, coord)
    col = convert_to_col_index(coord[0])
    row = convert_to_row_index(coord[1])
    piece.pos = coord
    arr[row][col] = piece
  end

  def print_board
    board_str = "    #{columns.join('  ')}"
    board_str += format_board
    board_str += "    #{columns.join('  ')}"
    puts board_str
  end

  def convert_to_indexes(coord)
    indexes = []
    indexes << convert_to_col_index(coord[0])
    indexes << convert_to_row_index(coord[1])
    indexes
  end

  def convert_to_col_index(col)
    columns.index(col)
  end

  def convert_to_row_index(row)
    (row.to_i - 8).abs
  end

  private

  def format_board(string = "\n", colors = %i[black grey])
    arr.each_with_index do |row_arr, row_n|
      string += " #{(row_n - 8).abs} "
      row_arr.each do |piece|
        string += " #{pieces(piece)} ".colorize(background: colors.first)
        colors.rotate!
      end
      string += " #{(row_n - 8).abs}\n"
      colors.rotate!
    end
    string
  end

  def pieces(piece)
    piece.nil? ? ' ' : piece
  end
end
