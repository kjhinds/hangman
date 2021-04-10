require_relative 'display'
require_relative 'board'
require_relative 'player'

class Game
  include Display

  def initialize
    @board = Board.new
    @players = []
    @current_turn = 0
    @winner = false
    @word = false
  end

  def play
    introduction
    game_setup
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
  end

  def turns
    @board.display_board
    current_player = @players[@current_turn % @players.length]
    guess = get_player_guess(current_player)
    @board.make_guess(guess)
    if @board.check_win
      @winner = current_player
      return
    end
    @current_turn += 1
    turns unless @board.check_lose
  end

  def conclusion
    @winner ? display_winner(@winner.name) : display_lose(@board.word)
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

  def get_player_guess(player)
    ask_guess(player.name)
    loop do
      guess = gets.chomp.downcase
      return guess if valid_guess?(guess)

      invalid_guess
    end
  end

  def valid_guess?(guess)
    guess.count('^a-z').zero? && @board.guesses.none?(guess)
  end
end
