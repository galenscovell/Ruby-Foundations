
# This program takes text input and builds a hash from that input.

def hash_creation(input)
    words = input.split(" ") # split text into array
    frequencies = Hash.new(0) # default hash value is 0
    words.each do |word|
        frequencies[word] += 1 # tallies each word
    end
    frequencies = frequencies.sort_by {|word, count| count} # sorts by count
    frequencies.reverse! # reverse previous sort so most frequent is top
    frequencies.each do |word, frequency| 
        puts word.capitalize + ": " + frequency.to_s # makes pretty
    end
end

puts "Enter some text: "
text = gets.chomp
hash_creation(text)