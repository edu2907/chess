# frozen_string_literal: true

# Manipulate the chess notation file
module NotationUtils
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
