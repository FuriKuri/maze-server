require_relative '../../../lib/maze/game/maze_game'
require_relative '../../../lib/maze/server/maze_server'
require_relative '../../../spec/spec_helper'

describe MazeGame do
  before do
    Maze.any_instance.stub(:fields).and_return(
        {[1, 1] => :exit,
         [1, 2] => :way,
         [2, 1] => :wall,
         [2, 2] => :way
        }
    )
    Array.any_instance.stub(:sample).and_return([1, 2])
    @client = Client.new('Player', nil)
    @maze_game = MazeGame.new({1 => @client})
    Maze.any_instance.stub(:exit?).with([1, 1]).and_return(true)
    Maze.any_instance.stub(:exit?).with([1, 2]).and_return(false)
  end

  it 'can show next moves for a player' do
    Maze.any_instance.stub(:directions_of_way_fields).and_return([:top])
    @maze_game.show_next_moves(@client).should == [:top]
  end

  it 'can say if player has reached the exit' do
    MazePlayer.any_instance.stub(:current_position).and_return([1, 1])
    @maze_game.reached_player_exit?.should be_true
  end

  it 'can say if no player has reached the exit' do
    MazePlayer.any_instance.stub(:current_position).and_return([1, 2])
    @maze_game.reached_player_exit?.should be_false
  end

  it 'can say which player has reached the exit' do
    MazePlayer.any_instance.stub(:current_position).and_return([1, 1])
    @maze_game.winning_players.should == ['Player']
  end

  it 'move player in maze' do
    MazePlayer.any_instance.should_receive(:move).with(:top)
    @maze_game.move(@client, :top)
  end

  it 'returns maze for player' do
    Maze.any_instance.stub(:to_s_for_player).and_return('maze')
    @maze_game.maze(@client).should == 'maze'
  end
end