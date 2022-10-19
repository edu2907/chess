# frozen_string_literal: true

require_relative 'piece'
require_relative 'pawn'
require_relative 'tower'
require_relative 'bisp'
require_relative 'knight'
require_relative 'queen'
require_relative 'king'

# Is a chess board
class Board
  include Enumerable
  include NotationUtils
  attr_reader :matrix

  def initialize(matrix_data)
    @matrix = create_board_matrix(matrix_data)
  end

  def at(pos)
    col, row = pos
    matrix[row][col]
  end

  def remove_at(pos)
    col, row = pos
    matrix[row][col] = nil
  end

  def place_at(piece, pos)
    col, row = pos
    matrix[row][col] = piece
  end

  def print_board
    board_str = "    #{columns.join('  ')}"
    board_str += format_board
    board_str += "    #{columns.join('  ')}"
    puts board_str
  end

  def each(&block)
    @matrix.flatten.each(&block)
  end

  def select_by_keys(**match_keys)
    select do |tile|
      match_keys.all? do |key, _value|
        !tile.nil? && tile.public_send(key) == match_keys[key]
      end
    end
  end

  def reject_by_keys(**match_keys)
    reject do |tile|
      match_keys.all? do |key, _value|
        tile.nil? || tile.public_send(key) == match_keys[key]
      end
    end
  end

  def to_arr
    matrix.map do |row|
      row.map do |piece|
        piece.nil? ? {} : piece.to_h
      end
    end
  end

  private

  def create_board_matrix(matrix_data)
    board_matrix = Array.new(8) { Array.new(8) }
    matrix_data.each_with_index do |row, row_i|
      row.each_with_index do |piece_data, col_i|
        piece_data[:pos] = [col_i, row_i]
        board_matrix[row_i][col_i] = create_piece(piece_data)
      end
    end
    board_matrix
  end

  def create_piece(piece_data)
    case piece_data[:notation_ltr]
    when 'N' then Knight.new(self, **piece_data)
    when 'R' then Tower.new(self, **piece_data)
    when 'Q' then Queen.new(self, **piece_data)
    when 'K' then King.new(self, **piece_data)
    when 'B' then Bisp.new(self, **piece_data)
    when '' then Pawn.new(self, **piece_data)
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
