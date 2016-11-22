require_relative 'piece'


class Pawn < Piece

  def initialize(pos)
    super
    @symbol = "1"
    @color = 'black'
  end

  def moves(current_pos, board)
    possibles = []

    if first_row?(current_pos) && @color == 'black'
      move_difs = move_diffs + [[2, 0]]
    elsif first_row?(current_pos)
      move_difs = move_diffs + [[-2, 0]]
    else
      move_difs = move_diffs
    end

    move_difs.each do |rel_pos|
      x_new = current_pos[0] + rel_pos[0]
      y_new = current_pos[1] + rel_pos[1]

      next if x_new < 0 || x_new > 7
      next if y_new < 0 || y_new > 7
      updated_pos = [x_new, y_new]
      possibles << updated_pos if board[updated_pos].is_a?(NullPiece)
    end

    possibles
  end

  def move_diffs
    @color == "black" ? [[1, 0]] : [[-1, 0]]
  end

  def first_row?(pos)
    pos[0] == 1 || pos[0] == 6
  end


end
