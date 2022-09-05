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
end
