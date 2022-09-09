# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

# Responsible for the logic of the Chess
class Game
  attr_reader :board

  def initialize(init_players_data)
    @board = Board.new
    @players = create_players(init_players_data)
    @current_player = @players[0]
  end

  def create_players(init_players_data)
    init_players_data.map { |init_player_data| Player.new(board, init_player_data) }
  end

  def run
    loop do
      execute_round

      return print_win_message if checkmate?
      return print_draw_message if draw?

      @current_player = @players.rotate!.first
    end
  end

  def execute_round
    system 'clear'
    puts " -> #{@current_player.name}'s Turn"
    @board.print_board
    @players.each { |player| puts "#{player.name}: #{player.mark_piece}" }
    @current_player.move_piece
  end
end
