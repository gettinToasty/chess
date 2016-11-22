require_relative 'cursor'
require_relative 'display'

class HumanPlayer

  def initialize(name, board)
    @board = board
    @name = name
    @cursor = Cursor.new([0, 0], board)
    @display = Display.new(@board, @cursor)
  end

  def get_pos
    move = nil

    until move
      system('clear')
      @display.render
      move = @cursor.get_input
    end
  end

  def play_turn
    start_pos = get_pos
    end_pos = get_pos

    board.move_piece(start_pos, end_pos)
    @display.render
  rescue
    puts "Invalid move"
    retry

  end

end
