# frozen_string_literal: true

require_relative 'notation_utils'
require_relative 'player'
require_relative 'board'

# Responsible for the logic of the Chess
class Game
  include NotationUtils
  include SaveUtils
  attr_reader :board

  def initialize(players_data, board_matrix)
    @board = Board.new(board_matrix)
    @players = create_players(players_data)
    @current_player = @players[0]
    create_save_files
  end

  def create_players(players_data)
    players_data.map { |player_data| Player.new(self, board:, **player_data) }
  end

  def run
    loop do
      update_game_status
      move = execute_round
      record_movement(move)

      return print_win_message if checkmate?
      return print_draw_message if draw?

      next_player
      save_game
    end
  end

  def execute_round
    system 'clear'
    puts " -> #{@current_player.name}'s Turn"
    @board.print_board
    @players.each { |player| puts "#{player.name}: #{player.mark_piece}" }
    @current_player.execute_action
  end

  def update_game_status
    update_check_status
    update_pieces_moveset
  end

  def update_pieces_moveset
    @board.each(&:update_move_set)
  end

  def update_check_status
    @board.select_by_keys(notation_ltr: 'K').each(&:verify_check_status)
  end

  def next_player
    @current_player = @players.rotate!.first
  end

  def checkmate?; end

  def draw?; end

  def to_h
    {
      board_matrix: @board.to_arr,
      players_data: @players.map(&:to_h)
    }
  end
end
