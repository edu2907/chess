# frozen_string_literal: true

# Nomenclatures
# Coordinate: [0, 6]
# Notation: a2

# Helper methods that manipulate notation data and register it into a file
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

  def castling?(arg)
    arg.match?(/\AO-O(-O)?\z/)
  end

  def move_notation(move)
    notation_ltr + move
  end

  def record_movement(move)
    filename = "saves/save#{$save_number}/move_record.txt"
    record_file = File.open(filename, 'r+')
    last_round = read_last_round(record_file)
    if new_round?(last_round)
      round_number = File.foreach(filename).inject(0) { |c, _line| c + 1 }
      record_file.print "#{round_number}. #{move} "
    else
      record_file.puts move
    end
    record_file.close
  end

  private

  def read_last_round(file)
    file_lines = file.readlines
    file_lines.empty? ? '' : file_lines.last
  end

  def new_round?(round_line)
    round_line.end_with?("\n") || round_line.empty?
  end
end
