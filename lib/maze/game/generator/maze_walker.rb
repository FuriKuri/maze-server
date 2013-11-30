class MazeWalker
  def initialize(fields, start_position, min_step = 3, max_step = 10)
    @fields = fields
    @start_position = start_position
    @max_step = max_step
    @min_step = min_step
    @width = fields[:width]
    @height = fields[:height]
  end

  def create_maze_way
    current_position = create_maze(@start_position)
    go_in_center_direction(current_position)
    5.times do
      create_maze(current_position)
    end
  end

  private
  def create_maze(start_position)
    current_position = start_position
    5.times do
      diff = [[1, 0], [0, 1], [-1, 0], [0, -1]].sample
      rand(@min_step..@max_step).times do
        new_x = current_position[0] + diff[0]
        new_y = current_position[1] + diff[1]
        new_position = [new_x, new_y]
        if @fields[new_position] == :wall
          @fields[new_position] = :way
          current_position = new_position
        end
      end
    end
    current_position
  end

  def go_in_center_direction(current_position)
    start_x = @start_position[0]
    start_y = @start_position[1]
    current_x = current_position[0]
    current_y = current_position[1]
    diff_x = (start_x - current_x).abs
    diff_y = (start_y - current_y).abs
    if diff_x < @width / 2
      (@width / 2).times do
        if start_x == 1
          current_x = current_x + 1
        end
        @fields[[current_x, current_y]] = :way
      end
    end
    if diff_y < @height / 2
      (@height / 2).times do
        if start_y == 1
          current_y = current_y + 1
        end
        @fields[[current_x, current_y]] = :way
      end
    end
    current_position = [current_x, current_y]
    create_maze(current_position)
  end
end