require_relative 'maze'
require_relative 'maze_player'
require 'set'

class MazeGame
  def initialize(clients)
    @players = Hash.new
    @maze = Maze.new(30, 30)
    start_position = rand_start_position
    clients.each do |client|
      @players[client] = MazePlayer.new(start_position, client.name)
    end
  end

  private
  def rand_start_position
     @maze.fields.reject{|_, field_type| field_type != :way}.keys.sample
  end
end

if __FILE__ == $0
  MazeGame.new(nil)
end