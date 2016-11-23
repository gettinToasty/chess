require_relative 'piece'
require 'byebug'

module SlidingPiece

  def moves(current_pos, board)
    possibles = []

    move_dirs.each do |rel_pos|
      p rel_pos

      x_new = current_pos[0] + rel_pos[0]
      y_new = current_pos[1] + rel_pos[1]

      updated_pos = [x_new, y_new]

      p check_pos?(updated_pos)


      if check_pos?(updated_pos)
        p @board[updated_pos].class

        while @board[updated_pos].is_a?(NullPiece)
          p updated_pos
          p board[updated_pos].class
          possibles << updated_pos.dup if check_pos?(updated_pos)

          #test_pos = [updated_pos[0] + rel_pos[0], updated_pos[1] +rel_pos[1]]

          updated_pos[0] += rel_pos[0] #if check_pos?(test_pos)
          updated_pos[1] += rel_pos[1] #if check_pos?(test_pos)
          break unless check_pos?(updated_pos)
        end
        p "hello #{updated_pos}"
        unless @board[updated_pos] && @board[current_pos].color == @board[updated_pos].color
          possibles << updated_pos if check_pos?(updated_pos)
          p board[updated_pos].class
        end
      end

    end
    p possibles
    possibles
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
