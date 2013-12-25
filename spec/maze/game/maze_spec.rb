require_relative '../../../lib/maze/game/maze'
require_relative '../../../lib/maze/game/generator/maze_generator'
require_relative '../../../spec/spec_helper'

describe Maze do
  before do
    @maze = Maze.new(5, 6)
  end

  it 'has a width' do
    @maze.width.should == 5
  end

  it 'has a height' do
    @maze.height.should == 6
  end

  context 'small maze' do
    before do
      MazeGenerator.any_instance.stub(:create).and_return(
          {[1, 1] => :way,
           [1, 2] => :way,
           [2, 1] => :wall,
           [2, 2] => :way
          })
      @maze = Maze.new(2, 2)
    end

    it 'generate a maze' do
      fields = @maze.fields
      fields[[1, 1]].should == :way
      fields[[1, 2]].should == :way
      fields[[2, 1]].should == :wall
      fields[[2, 2]].should == :way
    end

    it 'return the maze as string' do
      @maze.to_s.should == "****\n* x*\n*  *\n****\n"
    end

    it 'return the maze with a player' do
      @maze.to_s_for_player(1, [1, 1]) == "****\n*1x*\n*  *\n****\n"
    end
  end

  context 'medium maze' do
    before do
      MazeGenerator.any_instance.stub(:create).and_return(
          {[1, 1] => :wall,
           [1, 2] => :wall,
           [1, 3] => :wall,
           [2, 1] => :way,
           [2, 2] => :way,
           [2, 3] => :way,
           [3, 1] => :wall,
           [3, 2] => :exit,
           [3, 3] => :wall
          })
      @maze = Maze.new(3, 3)
    end

    it 'show all directions for a way' do
      @maze.possible_directions([2, 2]).should == [:top, :bottom, :right]
      @maze.possible_directions([1, 2]).should == [:right]
    end
  end

  context 'small maze with exit' do
    before do
      MazeGenerator.any_instance.stub(:create).and_return(
          {[1, 1] => :exit,
           [1, 2] => :way,
           [2, 1] => :wall,
           [2, 2] => :way
          })
      @maze = Maze.new(2, 2)
    end

    it 'has on 1, 1 an exit' do
      @maze.exit?([1, 1]).should be_true
    end

    it 'has on 2, 1 no exit' do
      @maze.exit?([2, 1]).should be_false
    end
  end
end