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

      return end_game_message if end_game?

      move = execute_round
      record_movement(move)
      next_player
    end
  end

  def execute_round
    system 'clear'
    puts " -> #{@current_player.name}'s Turn"
    puts @board
    @players.each do |player|
      puts "#{player.name}: #{player.mark_piece} #{player.check_message} "
    end
    @current_player.execute_action
  end

  def update_game_status
    promote_pawns
    update_pieces_moveset
    update_check_status
  end

  def update_pieces_moveset
    @board.each(&:update_pseudo_moves)
    @board.each(&:update_legal_moves)
  end

  def update_check_status
    @board.select_by_keys(notation_ltr: 'K').each(&:update_check_status)
  end

  def promote_pawns
    @board.select_by_keys(notation_ltr: '').each(&:promote)
  end

  def next_player
    @current_player = @players.rotate!.first
  end

  def end_game?
    !@current_player.can_play?
  end

  def end_game_message
    system 'clear'
    puts @board
    puts @current_player.check? ? print_win_message : print_draw_message
  end

  def win_message
    winner_name = @players.last.name
    "Checkmate! #{winner_name} wins!"
  end

  def draw_message
    stalemated_name = @current_player.name
    "Stalemate! #{stalemated_name} cannot move!"
  end

  def to_h
    {
      board_matrix: @board.to_arr,
      players_data: @players.map(&:to_h)
    }
  end
end
