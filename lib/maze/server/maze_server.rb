require 'socket'
require 'rubygems'
require 'json'

class MazeServer
  Player = Struct.new(:id, :name, :client)

  def initialize(number_of_players = 2)
    @players = []
    @number_of_players = number_of_players
  end

  def start
    connected_player = 0
    server = TCPServer.open(9999)
    while connected_player < @number_of_players
      socket = server.accept
      socket.puts('{"operation" : "REQUEST_PLAYER_NAME", "messageId": 1}')
      player_name = JSON.parse(socket.gets.chop)['playerName']
      @players <<  Player.new(connected_player, player_name, socket)
      puts "player #{player_name} connected"
      connected_player += 1
    end
    puts 'all player are connected'
  end

  def players
    @players
  end
end

if __FILE__ == $0
  server = MazeServer.new
  server.start
end