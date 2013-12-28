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
    @maze.possible_directions player_position
  end

  def move(client, orientation)
    @players[client].move(orientation)
  end

  def moves
    player_moves = {}
    @players.each do |client, player|
      player_moves[client.name] = player.moves
    end
    player_moves
  end

  def maze(client)
    @maze.to_s_for_player(client.number, @players[client].current_position)
  end

  def print_current_maze
    puts 'Maze Field'
    puts @maze.to_s
  end

  def reached_player_exit?
    !winning_players.empty?
  end

  def winning_players
    winning_players = []
    @players.each do |_, player|
      winning_players << player if @maze.exit?(player.current_position)
    end
    winning_players.map { |player| player.name }
  end

  private
  def rand_start_position
     @maze.fields.reject{|_, field_type| field_type != :way}.keys.sample
  end
end