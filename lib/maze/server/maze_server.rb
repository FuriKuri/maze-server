require 'socket'
require 'rubygems'
require 'json'
require_relative '../../../lib/maze/game/maze_game'

class MazeServer
  Client = Struct.new(:name, :client)

  def initialize(number_of_players = 2)
    @players = Hash.new
    @number_of_players = number_of_players
  end

  def start
    puts 'start server'
    connected_player = 0
    server = TCPServer.open(9999)
    while connected_player < @number_of_players
      connected_player += 1
      puts 'wait for player'
      socket = server.accept
      socket.puts('{"operation" : "REQUEST_PLAYER_NAME", "messageId": 1}')
      player_name = JSON.parse(socket.gets.chop)['playerName']
      @players[connected_player] = Client.new(player_name, socket)
      puts "player #{player_name} connected"
    end
    puts 'all player are connected'
    puts 'start game'
    @maze_game = MazeGame.new(@players)
    @maze_game.print_current_maze
  end

  def players
    @players
  end
end

if __FILE__ == $0
  server = MazeServer.new
  server.start
end