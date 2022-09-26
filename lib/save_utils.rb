# frozen_string_literal: true

require 'yaml'

# Saving and Loading File Methods
module SaveUtils
  def create_save_files
    save_dir = "saves/save#{$save_number}/"
    FileUtils.mkdir_p(save_dir) unless Dir.exist?(save_dir)
    FileUtils.touch("#{save_dir}move_record.txt")
    FileUtils.touch("#{save_dir}game_data.yaml")
  end

  def save_game
    game_data_hash = create_game_data
    game_data_yaml = YAML.dump(game_data_hash)
    save_file = File.open("saves/save#{$save_number}/game_data.yaml", 'w')
    save_file.puts(game_data_yaml)
    save_file.close
  end

  def self.new_game
    $save_number = Dir.glob('saves/*').size
    default_board_matrix = [
      ['R-black-a8', 'N-black-b8', 'B-black-c8', 'Q-black-d8', 'K-black-e8', 'B-black-f8', 'N-black-g8', 'R-black-h8'],
      ['-black-a7', '-black-b7', '-black-c7', '-black-d7', '-black-e7', '-black-f7', '-black-g7', '-black-h7'],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['', '', '', '', '', '', '', ''],
      ['-white-a2', '-white-b2', '-white-c2', '-white-d2', '-white-e2', '-white-f2', '-white-g2', '-white-h2'],
      ['R-white-a1', 'N-white-b1', 'B-white-c1', 'Q-white-d1', 'K-white-e1', 'B-white-f1', 'N-white-g1', 'R-white-h1']
    ]
    white_player = { color: 'white', name: nil }
    black_player = { color: 'black', name: nil }
    default_players_data = [white_player, black_player]

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

  private

  def create_game_data
    {
      board_matrix: @board.to_matrix_data,
      players_data: @players.map(&:to_player_data)
    }
  end
end
