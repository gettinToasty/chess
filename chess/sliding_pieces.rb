require_relative 'piece'
require 'byebug'

module SlidingPiece

  def moves(current_pos, board)
    possibles = []

    move_dirs.each do |rel_pos|

      possibles += grow_unblocked_moves_in_dir(rel_pos[0], rel_pos[1])
    end
    possibles
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    current_x = @position[0]
    current_y = @position[1]
    possibles_dir = []

    loop do
      current_x = current_x + dx
      current_y = current_y + dy
      pos = [current_x, current_y]

      break unless check_pos?(pos)

      if @board[pos].is_a?(NullPiece)
        possibles_dir << pos
      elsif @board[pos].color != @color
        possibles_dir << pos
        break
      end
    end

    possibles_dir
  end

  def check_pos?(pos)
    x_test = pos[0] >= 0 && pos[0] < 8
    y_test = pos[1] >= 0 && pos[1] < 8

    x_test && y_test
  end

  def move_dirs
    []
  end

  def horizontal_dirs
    [[0, 1], [0, -1], [1, 0], [-1, 0]]
  end

  def diagonal_dirs
    [[1, 1], [-1, 1], [-1, -1], [1, -1]]
  end

end

class Bishop < Piece
  include SlidingPiece

  def initialize(pos, color, board)
    super
    @symbol = @color == "black" ?  '♝' : '♗'
  end

  def move_dirs
    diagonal_dirs
  end

end

class Rook < Piece
  include SlidingPiece

  def initialize(pos, color, board)
    super
    @symbol = @color == "black" ?  '♜' : '♖'
  end

  def move_dirs
    horizontal_dirs
  end

end

class Queen < Piece
  include SlidingPiece

  def initialize(pos, color, board)
    super
    @symbol = @color == "black" ?  '♛' : '♕'
  end

  def move_dirs
    diagonal_dirs + horizontal_dirs
  end


end
