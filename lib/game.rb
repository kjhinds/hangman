require_relative 'display'
require_relative 'board'
require_relative 'player'

class Game
  include Display

  def initialize
    @board = Board.new
    @setup = false
    @players = []
    @current_turn = 0
  end

  def play
    introduction
    game_setup unless @setup
    turns
    conclusion
  end

  private

  def introduction
    display_introduction
  end

  def game_setup
    @board.pick_word
    ask_number_players
    response = total_players
    @players.push(create_player(@players.length + 1)) until @players.length == response
    @setup = true
  end

  def turns

  end

  def conclusion

  end

  def total_players
    response = gets.chomp.to_i
    return response if response.positive?

    number_players_error
    total_players
  end

  def create_player(number)
    ask_name(number)
    response = gets.chomp
    Player.new(response, number)
  end
end
