class Piece

  attr_reader :symbol, :position

  def initialize(position)
    @position = position
    @board = nil
    @color = nil
    @symbol = nil
  end

  def to_s
  end

  def empty?
  end

  def valid_moves
  end

  def move_into_check(to_pos)
  end

end
