# frozen_string_literal: true

require 'fileutils'
require_relative 'save_utils'
require_relative 'game'

ascii_display = <<HEREDOC
    /$$$$$$  /$$
   /$$__  $$| $$
  | $$  \\__/| $$$$$$$   /$$$$$$   /$$$$$$$ /$$$$$$$
  | $$      | $$__  $$ /$$__  $$ /$$_____//$$_____/
  | $$      | $$  \\ $$| $$$$$$$$|  $$$$$$|  $$$$$$
  | $$    $$| $$  | $$| $$_____/ \\____  $$\\____  $$
  |  $$$$$$/| $$  | $$|  $$$$$$$ /$$$$$$$//$$$$$$$/
   \\______/ |__/  |__/ \_______/|_______/|_______/

HEREDOC

puts ascii_display

if SaveUtils.save_file?
  $save_number = SaveUtils.pick_save_file
  if $save_number < SaveUtils.saves.size
    SaveUtils.load_game
  else
    SaveUtils.new_game
  end
else
  SaveUtils.new_game
end
