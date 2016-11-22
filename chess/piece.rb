require 'singleton'

class Piece

  attr_reader :symbol, :color
  attr_accessor :position, :board

  def initialize(position, color)
    @position = position
    @board = nil
    @color = color
    @symbol = nil
  end

  def empty?
  end

  def valid_moves
    possibles = moves(@position, @board)

    possibles.uniq.reject { |pos| move_into_check?(pos) }
  end

  def move_into_check?(end_pos)
    clone_board = @board.dup
    clone_board.move_piece!(@position, end_pos)

    return true if clone_board.in_check?(@color)

    false

  end

end

class NullPiece < Piece

  include Singleton

  def initialize
    @color = nil
    @symbol = " "
    @board = nil
  end

end
