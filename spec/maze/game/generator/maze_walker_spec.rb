require_relative '../../../../lib/maze/game/generator/maze_walker'

describe MazeWalker do
  it 'creates a way in a maze' do
    field = {
        [1, 1] => :way,
        [1, 2] => :wall,
        [1, 3] => :wall,
        [2, 1] => :wall,
        [2, 2] => :wall,
        [2, 3] => :wall,
        [3, 1] => :wall,
        [3, 2] => :wall,
        [3, 3] => :wall,
        :width => 3,
        :height => 3
    }
    #MazeWalker.any_instance.stub(:rand).with(2..2).and_return([1, 0])
    Array.any_instance.stub(:sample).and_return([1, 0])

    maze_walker = MazeWalker.new(field, [1, 1], 2, 2)
    maze_walker.create_maze_way
    field.should include(
        [1, 1] =>:way,
        [1, 2] => :wall,
        [1, 3] => :wall,
        [2, 1] => :way,
        [2, 2] => :wall,
        [2, 3] => :wall,
        [3, 1] => :way,
        [3, 2] => :way,
        [3, 3] => :wall,
    )
  end
end