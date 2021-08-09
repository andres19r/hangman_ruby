require_relative 'game'

def get_word(file)
  word = file.sample[0..-3]
  word = get_word(file) unless word.size >= 5 && word.size <= 12
  word.downcase
end

fname = '5desk.txt'
lines = File.readlines(fname)
word = get_word(lines)

puts 'Welcome to the game of Hangman!'
print 'Do you want to load a saved game? [y/n] '
res = gets.chomp
res = gets.chomp until %w[y n].include?(res)
if res == 'n'
  hangman = Game.new(word)
else
  begin
    saved = File.read('saved.json')
    hangman = Game.load_game(saved)
  rescue
    puts 'There is not a game saved.'
    puts 'Starting a new game'
    hangman = Game.new(word)
  end
end
hangman.start_game
