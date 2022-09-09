# frozen_string_literal: true

require 'colorize'

# Is a chess board
class Board
  attr_reader :columns, :arr

  def initialize
    @arr = Array.new(8) { Array.new(8) }
    @columns = %w[A B C D E F G H]
  end

  def at(coord)
    return unless coord.match?(/^[A-H][1-8]$/)

    col = convert_to_col(coord[0])
    row = coord[1].to_i - 1
    arr[row][col]
  end

  def remove_at(coord)
    col = convert_to_col(coord[0])
    row = coord[1].to_i - 1
    arr[row][col].pos = nil
    arr[row][col] = nil
  end

  def place_at(piece, coord)
    col = convert_to_col(coord[0])
    row = coord[1].to_i - 1
    piece.pos = coord
    arr[row][col] = piece
  end

  def print_board
    board_str = "    #{columns.join('  ')}"
    board_str += format_board
    board_str += "    #{columns.join('  ')}"
    puts board_str
  end

  private

  def format_board(string = "\n", colors = %i[black grey])
    arr.each_with_index do |row_arr, row_n|
      string += " #{row_n + 1} "
      row_arr.each do |piece|
        string += " #{pieces(piece)} ".colorize(background: colors.first)
        colors.rotate!
      end
      string += " #{row_n + 1}\n"
      colors.rotate!
    end
    string
  end

  def pieces(piece)
    piece.nil? ? ' ' : piece
  end

  def convert_to_col(letter)
    columns.index(letter)
  end
end
