require_relative 'maze'
require 'set'

class MazeGame
  def initialize(clients)
    @players = clients
    @maze = Maze.new(30, 30)
    start_position = rand_start_position
  end

  private
  def rand_start_position
     @maze.fields.reject{|_, field_type| field_type != :way}.keys.sample
  end
end

if __FILE__ == $0
  MazeGame.new(nil)
end