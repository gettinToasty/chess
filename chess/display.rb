require 'colorize'

class Display

  def initialize(board, cursor)
    @board = board
    @cursor = cursor
  end

  def render
    @board.grid.each_with_index do |row, i|
      row.each_with_index do |el, i2|
        if @cursor.cursor_pos == [i, i2]
          print " #{el.symbol} ".colorize( :background => :light_red )
        elsif (i + i2).even?
          print " #{el.symbol} ".colorize( :background => :light_black )
        else
          print " #{el.symbol} "
        end
      end
      puts ""
    end
    nil
  end



end
