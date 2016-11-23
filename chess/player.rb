require_relative 'cursor'
require_relative 'display'

class HumanPlayer

  attr_reader :name, :color
  attr_accessor :board

  def initialize(name, color)
    @board = nil
    @name = name
    @color = color

  end

  def update_curs_disp
    @cursor = Cursor.new([0, 0], @board)
    @display = Display.new(@board, @cursor)
  end


  def get_pos
    move = nil


    until move
      system('clear')
      @display.render
      move = @cursor.get_input
    end
    move
  end

  def play_turn
    start_pos = get_pos
    end_pos = get_pos

    raise if @board[start_pos].color != @color
    p "Move from #{start_pos} to #{end_pos}"
    sleep(1)
    board.move_piece(start_pos, end_pos)

  # rescue
  #   puts "Invalid move"
  #   sleep(1)
  #   retry

  end

end
