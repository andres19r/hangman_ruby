def get_word(file)
  word = file.sample[0..-3]
  word = get_word(file) unless word.size >= 5 && word.size <= 12
  word.downcase
end

def generate_hidden_word(word)
  n = word.size
  Array.new(n, '_')
end

def fill_in_letters(word, hidden_word, letter)
  ws = word.split('')
  ws.each_with_index do |let, index|
    hidden_word[index] = let if let == letter
  end
  hidden_word
end

fname = '5desk.txt'
lines = File.readlines(fname)
word = get_word(lines)
hidden_word = generate_hidden_word(word)
incorrect_letters = []
puts "#{hidden_word.join(' ')}"
i = 1
until i > 6
  print 'Letter? '
  letter = gets.chomp[0]
  if word.include?(letter)
    hidden_word = fill_in_letters(word, hidden_word, letter)
  else
    i += 1
    incorrect_letters << letter
  end
  puts "#{hidden_word.join(' ')}"
  puts "Incorrect letters: #{incorrect_letters.join('-')}"
end
