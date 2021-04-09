require_relative 'game'

def play_game
  game = Game.new
  game.play
  play_again
end

def play_again
  puts 'Would you like to play again? (y/n)'
  response = gets.chomp.downcase
  if response == 'y'
    play_game
  else
    puts 'Thanks for playing! See you next time!'
  end
end

play_game
