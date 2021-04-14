require_relative 'basic_serializable'
require_relative 'display'
require_relative 'board'
require_relative 'player'

class Game
  include Display
  include BasicSerializable

  def initialize
    @board = Board.new
    @players = []
    @current_turn = 0
    @winner = false
    @resume = false
  end

  def play
    introduction unless @resume
    game_setup unless @resume
    turns
    conclusion
  end

  def save(filename)
    file = File.open(filename, 'w')
    file.puts(serialize)
    file.close
    file_saved(filename)
  end

  def load
    loop do
      load_which_file
      Dir.mkdir('saves') unless Dir.exist?('saves')
      display_files(Dir.entries('saves'))
      response = gets.chomp
      break if response == ''

      next unless File.exist?("saves/#{response}")

      data = File.read("saves/#{response}")
      unserialize(data)
      break
    end
  end

  def serialize
    obj = {}
    obj['board'] = @board.serialize
    obj['players'] = @players.map(&:serialize)
    obj['current_turn'] = @current_turn
    obj['winner'] = @winner

    @@serializer.dump obj
  end

  def unserialize(string)
    obj = @@serializer.load(string)
    board = Board.new
    board.unserialize(obj['board'])
    @board = board
    @players = []
    obj['players'].each do |player_string|
      player = Player.new('', 0)
      player.unserialize(player_string)
      @players.push(player)
    end
    @current_turn = obj['current_turn']
    @winner = obj['winner']
    @resume = true
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
    current_player = @players[@current_turn % @players.length]
    guess = get_player_guess(current_player)
    @board.make_guess(guess)
    if @board.win?
      @winner = current_player
      return
    end
    @current_turn += 1
    turns unless @board.lose?
  end

  def conclusion
    @winner ? display_winner(@winner.name) : display_lose(@board.word)
  end

  def ask_filename
    ask_for_filename
    filename = gets.chomp
    check_filename(filename) ? save("saves/#{filename}") : not_saved
  end

  def check_filename(filename)
    return true unless File.exist?("saves/#{filename}")

    file_exists
    return true if gets.chomp.downcase == 'y'
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
    loop do
      @board.display_board
      ask_guess(player.name)
      ask_save
      guess = gets.chomp.downcase
      if guess == '/s'
        ask_filename
        next
      end
      return guess if valid_guess?(guess)

      invalid_guess
    end
  end

  def valid_guess?(guess)
    guess.count('^a-z').zero? && @board.guesses.none?(guess)
  end
end
