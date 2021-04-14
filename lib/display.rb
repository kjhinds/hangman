module Display
  def display_introduction
    puts "Let's play a game of Hangman!"
    puts "I'll choose a word, you try to guess it."
  end

  def ask_number_players
    puts 'How many players are there?'
  end

  def ask_name(number)
    puts "What is player #{number}'s name?"
  end

  def number_players_error
    puts 'Enter a number greater than 0.'
  end

  def display_hidden_word(array)
    puts ''
    puts array.join(' ')
  end

  def display_guesses(array)
    puts "Letters guessed: #{array.join(', ')}"
  end

  def ask_guess(name)
    puts "It's #{name}'s turn.  Guess a letter or guess the whole word."
  end

  def display_chances_left(number)
    puts "You have #{number} incorrect guess(es) left!"
  end

  def correct_guess(guess)
    puts "Yep! #{guess} is in the word!"
  end

  def incorrect_guess(guess)
    puts "Nope, #{guess} isn't a letter in the word!"
  end

  def correct_word(guess)
    puts "That's it! The word was #{guess}!"
  end

  def incorrect_word(guess)
    puts "Nope, the word isn't #{guess}."
  end

  def invalid_guess
    puts "Guess a letter (a-z) that hasn't already been picked!"
  end

  def display_winner(name)
    puts "Congratulations #{name}! You won!"
  end

  def display_lose(word)
    puts "Too bad! The word was #{word}"
  end

  def not_saved
    puts 'Game NOT saved.'
  end

  def file_saved(filename)
    puts "File saved as #{filename}"
  end

  def ask_save
    puts 'Type /s to save'
  end

  def ask_for_filename
    puts 'Filename?'
  end

  def file_exists
    puts 'File exists. Overwrite? (y/n)'
  end

  def load_which_file
    puts 'Which file to load?'
  end

  def display_files(files)
    puts files
  end
end
