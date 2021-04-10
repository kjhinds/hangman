class Board
  include Display
  attr_reader :incorrect_guesses, :guesses, :word

  def initialize
    @dictionary = File.read('5desk.txt')
                      .split(/\r\n/)
                      .select { |word| word.length.between?(5, 12) }
    @word = ''
    @guesses = []
    @incorrect_guesses = 0
    @chances = 10
  end

  def pick_word
    @word = @dictionary.sample.downcase
  end

  def display_board
    display_hidden_word(correct_letters)
    display_guesses(@guesses)
    display_chances_left(@chances - @incorrect_guesses)
  end

  def correct_letters
    @word.chars.map { |char| @guesses.include?(char) ? char : '_' }
  end

  def make_guess(guess)
    if guess.length > 1
      check_word(guess)
    else
      check_letter(guess)
    end
  end

  def check_word(guess)
    if @word == guess
      correct_word(guess)
      guess.chars.each do |char|
        @guesses.push(char).sort! unless @guesses.include?(char)
      end
    else
      @incorrect_guesses += 1
      incorrect_word(guess)
    end
  end

  def check_letter(guess)
    @guesses.push(guess).sort!
    if @word.include?(guess)
      correct_guess(guess)
    else
      @incorrect_guesses += 1
      incorrect_guess(guess)
    end
  end

  def check_win
    correct_letters.none?('_')
  end

  def check_lose
    @incorrect_guesses >= @chances
  end
end
