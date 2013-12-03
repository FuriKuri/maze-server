require_relative '../../../lib/maze/game/maze'
require_relative '../../../lib/maze/game/generator/maze_generator'

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
  end
end