# frozen_string_literal: true

require_relative 'notation_utils'
require_relative 'player'
require_relative 'board'

# Responsible for the logic of the Chess
class Game
  include NotationUtils
  attr_reader :board

  def initialize(init_players_data)
    @board = Board.new
    @players = create_players(init_players_data)
    @current_player = @players[0]
    @save_number = create_save_files
  end

  def create_players(init_players_data)
    init_players_data.map { |init_player_data| Player.new(board, init_player_data) }
  end

  def create_save_files
    Dir.mkdir('saves/') unless Dir.exist?('saves/')
    save_number = Dir.glob('saves/*').size
    save_dir = "saves/save#{save_number}/"
    Dir.mkdir(save_dir)
    FileUtils.touch("#{save_dir}move_record.txt")
    FileUtils.touch("#{save_dir}game_data.yaml")
    save_number
  end

  def run
    loop do
      move = execute_round
      record_movement(move)

      return print_win_message if checkmate?
      return print_draw_message if draw?

      next_player
    end
  end

  def execute_round
    system 'clear'
    puts " -> #{@current_player.name}'s Turn"
    @board.print_board
    @players.each { |player| puts "#{player.name}: #{player.mark_piece}" }
    @current_player.move_piece
  end

  def next_player
    @current_player = @players.rotate!.first
  end

  def checkmate?; end

  def draw?; end
end
