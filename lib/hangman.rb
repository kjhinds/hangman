require_relative 'game'

def play_game
  game = Game.new
  puts 'Load previous game? (y/n)'
  load(game) if gets.chomp.downcase == 'y'
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

def load(game)
  loop do
    puts 'Which file to load?'
    Dir.mkdir('saves') unless Dir.exist?('saves')
    puts Dir.entries('saves')
    response = gets.chomp
    break if response == ''

    next unless File.exist?("saves/#{response}")

    data = File.read("saves/#{response}")
    game.unserialize(data)
    break
  end
end

play_game
