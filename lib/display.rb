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
end
