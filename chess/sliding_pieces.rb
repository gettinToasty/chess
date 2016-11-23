require_relative 'piece'
require 'byebug'

module SlidingPiece

  def moves(current_pos, board)
    possibles = []
    move_dirs.each do |rel_pos|
      x_new = current_pos[0] + rel_pos[0]
      y_new = current_pos[1] + rel_pos[1]

      updated_pos = [x_new, y_new]

      x_test = updated_pos[0] >= 0 && updated_pos[0] < 8
      y_test = updated_pos[1] >= 0 && updated_pos[1] < 8

      if x_test && y_test

        while @board[updated_pos].is_a?(NullPiece)

          possibles << updated_pos.dup

          updated_pos[0] += rel_pos[0] if x_test
          updated_pos[1] += rel_pos[1] if y_test
        end

        unless @board[current_pos].color == @board[updated_pos].color
          possibles << updated_pos
        end
      end

    end
    possibles
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

  def grow_unblocked_moves_in_dir(dx, dy)
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
