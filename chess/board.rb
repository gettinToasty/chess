require_relative 'piece'
require_relative 'sliding_pieces'
require_relative 'stepping_pieces'
require_relative 'pawn'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    add_pieces
  end

  def add_pieces
    @grid.each_with_index do |row, i|
      row.each_index do |i2|
        if i <=1 || i >= 6
          @grid[i][i2] = Knight.new([i, i2])
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

  def move_piece(start_pos, end_pos)
    raise if self[start_pos].nil?
    raise if self[end_pos]

    begin
      self[end_pos] = self[start_pos]
      self[start_pos] = nil
    rescue
      puts "Invalid move"

    end

  end

end
