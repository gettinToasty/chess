require_relative 'piece'
require_relative 'sliding_pieces'
require_relative 'stepping_pieces'
require_relative 'pawn'
require 'byebug'

class Board

  attr_reader :grid

  def initialize(grid = Array.new(8) { Array.new(8) } )
    @grid = grid
  end

  def add_pieces
    @grid.each_with_index do |row, i|
      row.each_index do |i2|
        if i == 0
          @grid[i][i2] = end_row([i, i2], "black")
        elsif i == 1
          @grid[i][i2] = Pawn.new([i, i2], "black", self)
        elsif i == 6
          @grid[i][i2] = Pawn.new([i, i2], "white", self)
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
    when 0 then Rook.new(pos, color, self)
    when 1 then Knight.new(pos, color, self)
    when 2 then Bishop.new(pos, color, self)
    when 3 then King.new(pos, color, self)
    when 4 then Queen.new(pos, color, self)
    when 5 then Bishop.new(pos, color, self)
    when 6 then Knight.new(pos, color, self)
    when 7 then Rook.new(pos, color, self)
    end
  end

  def move_piece(start_pos, end_pos)
    raise if self[start_pos].is_a?(NullPiece)
    raise unless self[start_pos].valid_moves.include?(end_pos)

    self[start_pos].position = end_pos
    self[end_pos] = self[start_pos]

    self[start_pos] = NullPiece.instance

  end

  def move_piece!(start_pos, end_pos)
    raise if self[start_pos].is_a?(NullPiece)

    self[start_pos].position = end_pos
    self[end_pos] = self[start_pos]

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

    pieces = []
    @grid.each do |row|
      row.each do |el|
        pieces << el if el.color && el.color != color
      end
    end

    pieces.any? do |piece|
      piece.moves(piece.position, self).include?(op_king.position)
    end
  end

  def checkmate?(color)

    pieces = []
    @grid.each do |row|
      row.each do |el|
        pieces << el if el.color && el.color == color
      end
    end

    in_check?(color) && pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def dup

    new_g = @grid.map do |row|
      row.map do |el|
        clone_piece(el)
      end
    end

    Board.new(new_g)
  end

  def clone_piece(piece)
    dup_class = piece.class
    return dup_class.instance if piece.is_a?(NullPiece)
    dup_class.new(piece.position, piece.color, piece.board)
  end

end
