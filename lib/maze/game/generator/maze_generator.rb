require_relative 'maze_walker'

class MazeGenerator
  def initialize(width, height)
    @width = width
    @height = height
  end

  def create
    fields = init_field
    start_position = create_exit(fields)
    create_way(fields, start_position)
    fields
  end

  private
  def create_exit(fields)
    exit_orientation = [:top, :right, :bottom, :left].sample
    case exit_orientation
      when :top
        x = rand(1..@width)
        start_position = [x, 1]
        fields[[x, 0]] = :exit
      when :bottom
        x = rand(1..@width)
        start_position = [x, @height]
        fields[[x, @height + 1]] = :exit
      when :left
        y = rand(1..@height)
        start_position = [1, y]
        fields[[0, y]] = :exit
      when :right
        y = rand(1..@height)
        start_position = [@width, y]
        fields[[@width + 1, y]] = :exit
      else
        start_position = [1, 1]
        fields[[0, 1]] = :exit
    end
    start_position
  end

  def create_way(fields, start_position)
    fields[start_position] = :way
    MazeWalker.new(fields, start_position).create_maze_way
    MazeWalker.new(fields, start_position, 4, 20).create_maze_way
    MazeWalker.new(fields, start_position, 4, 20).create_maze_way
    MazeWalker.new(fields, start_position, 4, 20).create_maze_way
    MazeWalker.new(fields, start_position, 10, 20).create_maze_way
    MazeWalker.new(fields, start_position, 10, 20).create_maze_way
    MazeWalker.new(fields, start_position, 10, 20).create_maze_way
    MazeWalker.new(fields, start_position, 10, 20).create_maze_way
    MazeWalker.new(fields, start_position, 10, 20).create_maze_way
    MazeWalker.new(fields, start_position, 10, 20).create_maze_way
    MazeWalker.new(fields, start_position, 10, 20).create_maze_way
    MazeWalker.new(fields, start_position, 10, 20).create_maze_way
    MazeWalker.new(fields, start_position, 10, 20).create_maze_way
  end

  def init_field
    fields = Hash.new
    fields[:width] = @width
    fields[:height] = @height
    @width.times do |x|
      @height.times do |y|
        fields[[x + 1, y + 1]] = :wall
      end
    end
    fields
  end
end