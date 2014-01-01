require 'socket'
require 'rubygems'
require 'json'
require_relative '../../../lib/maze/game/maze_game'

Client = Struct.new(:name, :socket, :number)

class MazeServer
  def initialize(hostname = 'localhost', port = 9999, number_of_players = 1)
    @hostname = hostname
    @port = port
    @players = Hash.new
    @number_of_players = number_of_players
  end

  def start
    puts "start server on port #{@port} with hostname #{@hostname}"
    connected_player = 0
    server = TCPServer.open(@hostname, @port)
    while connected_player < @number_of_players
      connected_player += 1
      puts 'wait for player'
      socket = server.accept
      socket.puts('{"operation" : "PLAYER_NAME", "messageId": 1, "type": "REQUEST"}')
      player_name = JSON.parse(socket.gets.chop)['playerName']
      @players[connected_player] = Client.new(player_name, socket, connected_player)
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

  def start_game
    until @maze_game.all_players_reached_exit?
      do_moves
    end
    puts @maze_game.moves
    confirm_clients
  end

  private
  def do_moves
    @players.each do |player_number, client|
      unless @maze_game.player_reached_exit?(client)
        puts "Print maze for player #{client.name}"
        puts @maze_game.maze(client)
        next_moves = @maze_game.show_next_moves(client).map { |move| move.to_s }
        client.socket.puts('{"operation" : "NEXT_MOVE", "messageId" : 2, "type": "REQUEST", "data" : ' + next_moves.to_s + '}')
        move = JSON.parse(client.socket.gets.chop)['move'].to_sym
        @maze_game.move(client, move)
      end
    end
  end

  def confirm_clients
    @players.each do |player_number, client|
      client.socket.puts('{"operation" : "PLAYER_MOVES", "messageId" : 3, "type": "NOTIFICATION", "data" : ' + @maze_game.moves.to_json + '}')
      client_msg = client.socket.gets.chop
      puts "#{client.name} send message #{client_msg}"
    end
  end
end