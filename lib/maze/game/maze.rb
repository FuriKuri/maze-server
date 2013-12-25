require_relative 'generator/maze_generator'

class Maze
  attr_reader :width, :height, :fields

  def initialize(width, height)
    @width = width
    @height = height
    @fields = MazeGenerator.new(width, height).create
  end

  def possible_directions(position)
    way_fields = []
    way_fields << :top if way_or_exit_field? position, [0, -1]
    way_fields << :bottom if way_or_exit_field? position, [0, +1]
    way_fields << :left if way_or_exit_field? position, [-1, 0]
    way_fields << :right if way_or_exit_field? position, [+1, 0]
    way_fields
  end

  def exit?(position)
    @fields[position] == :exit
  end

  def to_s_for_player(player_number = nil, player_position)
    field_to_s(player_number, player_position)
  end

  def to_s
    field_to_s
  end

  private
  def field_to_s(player_number = nil, player_position = nil)
    field_as_string = ''
    (@height + 2).times do |y|
      (@width + 2).times do |x|
        field_as_string << map_field_element([x, y], player_number, player_position)
      end
      field_as_string << "\n"
    end
    field_as_string
  end

  def way_or_exit_field?(position, diff)
    position = [position[0] + diff[0], position[1] + diff[1]]
    @fields[position] == :way || @fields[position] == :exit
  end

  def map_field_element(position, player_number, player_position)
    case @fields[position]
      when :wall
        'x'
      when :way
        if player_position == position
          player_number.to_s
        else
          ' '
        end
      when :exit
        'O'
      else
        '*'
    end
  end
end