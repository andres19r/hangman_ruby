class Game
  require 'json'
  require_relative 'draw'
  include Draw
  attr_accessor :word, :hidden_word, :turns, :incorrect_letters

  def initialize(word)
    @word = word
    @hidden_word = generate_hidden_word(word)
    @turns = 0
    @incorrect_letters = []
  end

  def start_game
    until @turns > 5
      puts "Word: #{@hidden_word.join(' ')}"
      puts Draw::STAGES[@turns]
      print 'Letter? '
      letter = gets.chomp.downcase
      if letter == 'ss'
        save_game
        break
      end
      verify_letter(letter)
      puts "Incorrect letters: #{@incorrect_letters.join('-')}"
    end
    game_lost if @turns == 6
  end

  def save_game
    saved = JSON.dump({
                word: @word,
                hidden_word: @hidden_word,
                turns: @turns,
                incorrect_letters: @incorrect_letters
                })
    File.open('saved.json', 'w'){ |file| file.puts saved }
  end

  def self.load_game(string)
    data = JSON.parse(string)
    loaded = Game.new(data['word'])
    loaded.hidden_word = data['hidden_word']
    loaded.turns = data['turns']
    loaded.incorrect_letters = data['incorrect_letters']
    loaded
  end

  private

  def generate_hidden_word(word)
    n = word.size
    Array.new(n, '_')
  end

  def verify_letter(letter)
    if @word.include?(letter)
      @hidden_word = fill_in_letters(letter)
    else
      @turns += 1
      @incorrect_letters << letter
    end
  end

  def fill_in_letters(letter)
    ws = @word.split('')
    ws.each_with_index do |let, index|
      @hidden_word[index] = let if let == letter
    end
    @hidden_word
  end

  def game_lost
    puts Draw::STAGES[6]
    puts "The word was: #{@word}"
  end
end
