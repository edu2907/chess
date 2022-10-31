# frozen_string_literal: true

# Nomenclatures
# Coordinate: [0, 6]
# Notation: a2

# Helper methods that manipulate notation input data
module NotationUtils
  def convert_to_coordinate(coord)
    coordinate = []
    coordinate << convert_to_col_coord(coord[0])
    coordinate << convert_to_row_coord(coord[1])
    coordinate
  end

  def convert_to_col_coord(col)
    columns.index(col)
  end

  def convert_to_row_coord(row)
    (row.to_i - 8).abs
  end

  def columns
    %w[a b c d e f g h]
  end

  def notation?(arg)
    arg.match?(/^[a-h][1-8]$/)
  end
end
