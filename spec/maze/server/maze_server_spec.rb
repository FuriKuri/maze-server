require_relative '../../../lib/maze/server/maze_server'
require_relative '../../../lib/maze/server/version'
require_relative '../../../lib/maze/game/maze_game'
require 'socket'
require_relative '../../../spec/spec_helper'

describe MazeServer do

  it 'maze server has a version' do
    Maze::Server::VERSION.should_not be_empty
  end

  it 'get player name if they are connected' do
    response = double('response', :chop => '{"playerName" : "player"}')
    socket = double('socket', :gets => response, :puts => nil)
    server = double('server', :accept => socket)
    TCPServer.stub(:open).with(1, 9999).and_return(server)
    server = MazeServer.new(1)
    server.start
    server.players[1].name.should == 'player'
  end

  context 'server runs' do
    before do
      response = double('response', :chop => '{"playerName" : "player"}')
      socket = double('socket', :gets => response, :puts => nil)
      server = double('server', :accept => socket)
      TCPServer.stub(:open).with(1, 9999).and_return(server)
      @server = MazeServer.new(1)
      @server.start
    end

    it 'handle a game' do
      MazeGame.any_instance.stub(:all_players_reached_exit?).and_return(false, true)
      response = double('response', :chop => '{"move" : "left"}')
      socket = double('socket', :gets => response, :puts => nil)
      Client.any_instance.stub(:socket).and_return(socket)
      @server.start_game
    end
  end

end