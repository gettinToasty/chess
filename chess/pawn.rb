require_relative 'piece'
require 'byebug'

class Pawn < Piece

  def initialize(pos, color)
    super
    @symbol = @color == "black" ?  '♟' : '♙'
  end

  def moves(current_pos, board)
    possibles = []

    pot_moves = first_row?(current_pos) ? first_move : move_diffs


    pot_moves.each_with_index do |rel_pos, idx|
      x_new = current_pos[0] + rel_pos[0]
      y_new = current_pos[1] + rel_pos[1]

      next if x_new < 0 || x_new > 7
      next if y_new < 0 || y_new > 7

      updated_pos = [x_new, y_new]

      if first_row?(current_pos)

        if idx == 0
          block = [x_new - pot_moves[1][0], y_new]
          if board[updated_pos].is_a?(NullPiece) && !board[block].color
            possibles << updated_pos
          end

        elsif idx == 1
          possibles << updated_pos if board[updated_pos].is_a?(NullPiece)
        else
          share_color = board[updated_pos].color == board[current_pos].color
          unless board[updated_pos].is_a?(NullPiece) || share_color
            possibles << updated_pos
          end
        end

      else

        if idx == 0
          possibles << updated_pos if board[updated_pos].is_a?(NullPiece)
        else
          if board[updated_pos].color != board[current_pos].color
            possibles << updated_pos
          end
        end

      end


    end

    possibles
  end

  def first_move
    first = move_diffs.dup
    if @color == 'black'
      first.unshift([2, 0])
    else
      first.unshift([-2, 0])
    end
    first
  end

  def move_diffs
    @color == "black" ? [[1,0], [1,-1], [1,1]] : [[-1,0], [-1,1], [-1,-1]]
  end

  def first_row?(pos)
    pos[0] == 1 || pos[0] == 6
  end


end
