# frozen_string_literal: true

require 'colorize'

# Is a chess board
class Board
  attr_reader :columns, :matrix

  def initialize(matrix_data)
    @matrix = create_board_matrix(matrix_data)
    @columns = %w[a b c d e f g h]
  end

  # Accepts values as a coordinate ("A2") or indexes string
  def at(pos)
    is_coordinate = ->(str) { str.match?(/^[a-h][1-8]$/) }
    is_indexes = ->(str) { str.match?(/^[0-7][0-7]$/) }

    case pos
    when is_coordinate
      row = convert_to_row_index(pos[1])
      col = convert_to_col_index(pos[0])
    when is_indexes
      row = pos[1].to_i
      col = pos[0].to_i
    else return
    end

    matrix[row][col]
  end

  def remove_at(coord)
    col = convert_to_col_index(coord[0])
    row = convert_to_row_index(coord[1])
    matrix[row][col].pos = nil
    matrix[row][col] = nil
  end

  def place_at(piece, coord)
    col = convert_to_col_index(coord[0])
    row = convert_to_row_index(coord[1])
    piece.pos = coord
    matrix[row][col] = piece
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

  def to_matrix_data
    matrix.map do |row|
      row.map do |piece|
        piece.nil? ? nil : piece.to_piece_data
      end
    end
  end

  private

  def create_board_matrix(matrix_data)
    board_matrix = Array.new(8) { Array.new(8) }
    matrix_data.each_with_index do |row, row_i|
      row.each_with_index do |piece_data, col_i|
        board_matrix[row_i][col_i] = create_piece(piece_data)
      end
    end
    board_matrix
  end

  def create_piece(piece)
    return if piece.nil?

    piece_ltr, piece_color, piece_pos = piece.split('-')
    case piece_ltr
    when 'K' then King.new(board: self, color: piece_color, pos: piece_pos)
    when 'Q' then Queen.new(board: self, color: piece_color, pos: piece_pos)
    when 'B' then Bisp.new(board: self, color: piece_color, pos: piece_pos)
    when 'N' then Knight.new(board: self, color: piece_color, pos: piece_pos)
    when 'R' then Tower.new(board: self, color: piece_color, pos: piece_pos)
    when '' then Pawn.new(board: self, color: piece_color, pos: piece_pos)
    end
  end

  def format_board(string = "\n", colors = %i[black grey])
    matrix.each_with_index do |row_arr, row_n|
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
