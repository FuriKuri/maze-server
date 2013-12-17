require_relative 'generator/maze_generator'

class Maze
  attr_reader :width, :height, :fields

  def initialize(width, height)
    @width = width
    @height = height
    @fields = MazeGenerator.new(width, height).create
  end

  def directions_of_way_fields(position)
    way_fields = []
    way_fields << :top if way_field? position, [0, -1]
    way_fields << :bottom if way_field? position, [0, +1]
    way_fields << :left if way_field? position, [-1, 0]
    way_fields << :right if way_field? position, [+1, 0]
    way_fields
  end

  def exit?(position)
    @fields[position] == :exit
  end

  def to_s
    field_as_string = ''
    (@height + 2).times do |y|
      (@width + 2).times do |x|
        field_as_string << map_field_element(fields[[x, y]])
      end
      field_as_string << "\n"
    end
    field_as_string
  end

  private
  def way_field?(position, diff)
    position = [position[0] + diff[0], position[1] + diff[1]]
    @fields[position] == :way
  end

  def map_field_element(element)
    case element
      when :wall
        'x'
      when :way
        ' '
      when :exit
        'O'
      else
        '*'
    end
  end
end

if __FILE__ == $0
  maze = Maze.new(30, 30)
  puts maze.to_s
end