require_relative 'maze'
require_relative 'maze_player'
require 'set'

class MazeGame
  def initialize(clients)
    @players = Hash.new
    @maze = Maze.new(30, 30)
    start_position = rand_start_position
    clients.each do |_, client|
      @players[client] = MazePlayer.new(start_position, client.name)
    end
  end

  def show_next_moves(client)
    player_position = @players[client].current_position
    @maze.directions_of_way_fields player_position
  end

  def print_current_maze
    puts 'Maze Field'
    puts @maze.to_s
  end

  private
  def rand_start_position
     @maze.fields.reject{|_, field_type| field_type != :way}.keys.sample
  end
end

if __FILE__ == $0
  MazeGame.new(nil)
end