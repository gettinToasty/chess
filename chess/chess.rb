require_relative 'player'
require_relative 'board'

class ChessGame

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new.add_pieces

  end

  def play
    current_player = @player1
    color = current_player == @player1 ? "white" : "black"
    until @board.checkmate?(color)
      system('clear')
      puts "#{current_player.name}\'s (#{color}) turn"
      current_player.play_turn
      current_player = current_player == @player1 ? @player2 : @player1
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  player_1 = Player.new("Sean")
  player_2 = Player.new("Jeff")
  game = ChessGame(player_1, player_2)
  game.play
end
