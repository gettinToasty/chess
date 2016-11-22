require_relative 'piece'

module SteppingPiece

  def moves(current_pos, board)
    possibles = []

    move_diffs.each do |rel_pos|
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
    []
  end

end


class King < Piece
  include SteppingPiece

  def initialize(pos, color)
    super
    @symbol = @color == "black" ?  '♚' : '♔'
  end

  def move_diffs
    [[0, 1], [0, -1], [1, 0], [-1, 0],
     [1, 1], [-1, 1], [-1, -1], [1, -1]]
  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(pos, color)
    super
    @symbol = @color == "black" ?  '♞' : '♘'
  end

  def move_diffs
    [[2, 1], [2, -1], [1, 2], [-1, 2],
     [1, -2], [-1, -2], [-2, -1], [-2, 1]]
  end

end
