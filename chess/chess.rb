require_relative 'player'
require_relative 'board'

class ChessGame

  def initialize(player1, player2)

    @board = Board.new
    @board.add_pieces
    @player1 = player1
    @player2 = player2
    @player1.board = @board
    @player2.board = @board
    @player1.update_curs_disp
    @player2.update_curs_disp

  end

  def play
    current_player = @player1
    until @board.checkmate?(current_player.color)
      system('clear')
      puts "#{current_player.name}\'s (#{current_player.color}) turn"
      sleep(1)
      current_player.play_turn
      current_player = current_player == @player1 ? @player2 : @player1
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  player_1 = HumanPlayer.new("Sean", "white")
  player_2 = HumanPlayer.new("Jeff", "black")
  game = ChessGame.new(player_1, player_2)
  game.play
end
