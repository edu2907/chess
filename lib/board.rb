# frozen_string_literal: true

# Is a chess board
class Board
  attr_reader :columns, :arr

  def initialize
    @arr = Array.new(8) { Array.new(8) }
    @columns = %w[A B C D E F G H]
  end

  def place_at(piece, coord)
    col = convert_to_col(coord[0])
    row = coord[1].to_i - 1
    arr[row][col] = piece
  end

  private

  def convert_to_col(letter)
    columns.index(letter)
  end
end
