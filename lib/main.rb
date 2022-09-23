# frozen_string_literal: true

require 'fileutils'
require_relative 'game'

# This is a 'model' player struct which contains initial data for creation of the actual players
InitPlayerData = Struct.new(:color, :main_row, :pawn_row)
white_player = InitPlayerData.new 'white', 1, 2
black_player = InitPlayerData.new 'black', 8, 7
init_players_data = [white_player, black_player]

Game.new(init_players_data).run
