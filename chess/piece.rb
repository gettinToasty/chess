require 'singleton'

class Piece

  attr_reader :symbol, :position

  def initialize(position, color)
    @position = position
    @board = nil
    @color = color
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

class NullPiece < Piece

  include Singleton

  def initialize
    @color = nil
    @symbol = " "
  end

end
