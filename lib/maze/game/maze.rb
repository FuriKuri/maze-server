require_relative 'generator/maze_generator'

class Maze
  attr_reader :width, :height, :fields

  def initialize(width, height)
    @width = width
    @height = height
    @fields = MazeGenerator.new(width, height).create
  end

  def to_s
    field_as_string = ''
    (@height + 2).times do |y|
      (@width + 2).times do |x|
        field_as_string += map_field_element(fields[[x, y]])
      end
      field_as_string += "\n"
    end
    field_as_string
  end

  private
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