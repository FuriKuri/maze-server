class MazePlayer
  attr_reader :current_position, :name, :moves

  def initialize(current_position, name)
    @current_position = current_position
    @name = name
    @moves = 0
  end

  def move(orientation)
    case orientation
      when :top
        move_top
      when :bottom
        move_bottom
      when :left
        move_left
      when :right
        move_right
    end
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
    @moves += 1
  end
end