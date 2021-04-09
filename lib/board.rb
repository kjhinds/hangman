class Board
  include Display
  attr_reader :word

  def initialize
    @dictionary = File.read('5desk.txt')
                      .split(/\r\n/)
                      .select { |word| word.length.between?(5, 12) }
    @word = ''
  end

  def pick_word
    @word = @dictionary.sample
  end
end
