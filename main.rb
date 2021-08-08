require_relative 'game'

def get_word(file)
  word = file.sample[0..-3]
  word = get_word(file) unless word.size >= 5 && word.size <= 12
  word.downcase
end

fname = '5desk.txt'
lines = File.readlines(fname)
word = get_word(lines)

hangman = Game.new(word)
hangman.start_game
