require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |el, i2|
        if @cursor.cursor_pos == [i, i2]
          print "#{el.symbol} ".colorize( :background => :light_red )
        else
          print "#{el.symbol} "
        end
      end
      puts ""
    end
    nil
  end

  def move_around
    move = nil

    until move
      system('clear')
      render
      move = @cursor.get_input
    end
  end

end
