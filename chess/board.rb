require_relative 'piece'
require_relative 'sliding_pieces'
require_relative 'stepping_pieces'
require_relative 'pawn'
require 'byebug'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    add_pieces
  end

  def add_pieces
    @grid.each_with_index do |row, i|
      row.each_index do |i2|
        if i == 0
          @grid[i][i2] = end_row([i, i2], "black")
        elsif i == 1
          @grid[i][i2] = Pawn.new([i, i2], "black")
        elsif i == 6
          @grid[i][i2] = Pawn.new([i, i2], "white")
        elsif i == 7
          @grid[i][i2] = end_row([i, i2], "white")
        else
          @grid[i][i2] = NullPiece.instance
        end
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    @grid[x][y] = val
  end

  def end_row(pos, color)

    case pos[1]
    when 0 then Rook.new(pos, color)
    when 1 then Knight.new(pos, color)
    when 2 then Bishop.new(pos, color)
    when 3 then King.new(pos, color)
    when 4 then Queen.new(pos, color)
    when 5 then Bishop.new(pos, color)
    when 6 then Knight.new(pos, color)
    when 7 then Rook.new(pos, color)
    end
  end

  def move_piece(start_pos, end_pos)
    raise if self[start_pos].is_a?(NullPiece)
    raise unless self[end_pos].is_a?(NullPiece)


    self[end_pos] = self[start_pos]
    self[end_pos].position = end_pos
    self[start_pos] = NullPiece.instance
    rescue
      puts "Invalid move"


  end

  def in_check?(color)

    op_king = nil
    @grid.each do |row|
      row.each do |el|
        op_king = el if el.is_a?(King) && el.color == color
      end
    end
    # debugger
    pieces = []
    @grid.each do |row|
      row.each do |el|
        pieces << el if el.color && el.color != color
      end
    end

    pieces.any? do |piece|
      p piece
      piece.moves(piece.position, self).include?(op_king.position)
    end
  end

  def checkmate(color)
  end

end
