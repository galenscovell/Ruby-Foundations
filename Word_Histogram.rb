
# This program takes text input and builds a hash from that input.

def hash_creation(input)
  words = input.split(" ")
  frequencies = Hash.new(0)
  words.each do |word|
    frequencies[word] += 1
  end
  frequencies = frequencies.sort_by {|word, count| count}
  frequencies.reverse!
  frequencies.each do |word, frequency| 
    puts word.capitalize + ": " + frequency.to_s
  end
end

puts "Enter some text: "
text = gets.chomp
hash_creation(text)