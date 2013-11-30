require_relative '../../../lib/maze/game/generator/maze_generator'
require_relative '../../../lib/maze/game/generator/maze_walker'

describe MazeGenerator do
  it 'creates a empty maze' do
    MazeWalker.any_instance.stub(:create_maze_way)
    Array.any_instance.stub(:sample).and_return(:top)
    MazeGenerator.any_instance.stub(:rand).with(1..2).and_return(1)
    fields = MazeGenerator.new(2, 2).create
    fields.should include([1, 1] =>:way, [1, 2] => :wall, [2, 1] => :wall, [2, 2] => :wall)
    fields.should include([1, 0] =>:exit)
  end
end