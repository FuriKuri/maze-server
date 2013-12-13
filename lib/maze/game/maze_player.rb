class MazePlayer
  attr_reader :current_position, :name

  def initialize(current_position, name)
    @current_position = current_position
    @name = name
  end

  def move_top
    do_move [0, -1]
  end

  def move_bottom
    do_move [0, 1]
  end

  def move_left
    do_move [-1, 0]
  end

  def move_right
    do_move [1, 0]
  end

  private
  def do_move(diff)
    @current_position = [@current_position[0] + diff[0],
                         @current_position[1] + diff[1]]
  end
end