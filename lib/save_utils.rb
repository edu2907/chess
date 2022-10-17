# frozen_string_literal: true

require 'yaml'

# Saving and Loading File Methods
module SaveUtils
  def create_save_files
    save_dir = "saves/save#{$save_number}/"
    FileUtils.mkdir_p(save_dir) unless Dir.exist?(save_dir)
    FileUtils.touch("#{save_dir}move_record.txt")
    FileUtils.touch("#{save_dir}game_data.yaml")
    save_game
  end

  def save_game
    game_data_hash = to_h
    game_data_yaml = YAML.dump(game_data_hash)
    save_file = File.open("saves/save#{$save_number}/game_data.yaml", 'w')
    save_file.puts(game_data_yaml)
    save_file.close
  end

  def self.new_game
    $save_number = Dir.glob('saves/*').size
    new_game_data = YAML.load_file('new_game_data.yaml')
    default_board_matrix = new_game_data[:board_matrix]
    default_players_data = new_game_data[:players_data]
    Game.new(default_players_data, default_board_matrix).run
  end

  def self.save_file?
    Dir.exist?('saves') && !Dir.glob('saves/*').empty?
  end

  def self.pick_save_file
    is_file_number = ->(file_number) { file_number.match?(/^\d+$/) && file_number.to_i < saves.size }
    loop do
      save_number = choose_save_file
      case save_number
      when 'n' then return saves.size
      when is_file_number then return save_number.to_i
      else puts 'Invalid option!'
      end
    end
  end

  def self.load_game
    game_data = YAML.load_file("saves/save#{$save_number}/game_data.yaml")
    players_data = game_data[:players_data]
    board_matrix = game_data[:board_matrix]
    Game.new(players_data, board_matrix).run
  end

  def self.saves
    Dir.glob('saves/*')
  end

  def self.choose_save_file
    save_files = saves
    save_files.each_with_index { |save_name, save_number| puts "#{save_number} - #{save_name}" }
    puts "Insert the save number to load the file or 'n' to load a new game."
    gets.chomp
  end

  private_class_method :choose_save_file
end
