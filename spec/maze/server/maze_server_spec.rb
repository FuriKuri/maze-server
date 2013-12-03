require_relative '../../../lib/maze/server/maze_server'
require 'socket'

describe MazeServer do
  it 'get player name if they are connected' do
    response = double('response', :chop => '{"playerName" : "player"}')
    socket = double('socket', :gets => response, :puts => nil)
    server = double('server', :accept => socket)
    TCPServer.stub(:open).with(9999).and_return(server)
    server = MazeServer.new(1)
    server.start
    server.players[1].name.should == 'player'
  end
end