require_relative '../../../lib/maze/game/maze_player'
require_relative '../../../spec/spec_helper'

describe MazePlayer do
  before do
    @player = MazePlayer.new([5, 5], 'Player One')
  end

  it 'has a name' do
    @player.name.should == 'Player One'
  end

  it 'has a position' do
    @player.current_position == [5, 5]
  end

  it 'can move on step to top' do
    @player.move_top
    @player.current_position.should == [5, 4]
  end

  it 'can move on step to orientation top' do
    @player.move(:top)
    @player.current_position.should == [5, 4]
  end

  it 'can move on step to bottom' do
    @player.move_bottom
    @player.current_position.should == [5, 6]
  end

  it 'can move on step to orientation bottom' do
    @player.move(:bottom)
    @player.current_position.should == [5, 6]
  end

  it 'can move on step to left' do
    @player.move_left
    @player.current_position.should == [4, 5]
  end

  it 'can move on step to orientation left' do
    @player.move(:left)
    @player.current_position.should == [4, 5]
  end

  it 'can move on step to right' do
    @player.move_right
    @player.current_position.should == [6, 5]
  end

  it 'can move on step to orientation right' do
    @player.move(:right)
    @player.current_position.should == [6, 5]
  end

  it 'count the moves' do
    @player.move(:right)
    @player.move(:right)
    @player.move(:right)
    @player.moves.should == 3
  end
end