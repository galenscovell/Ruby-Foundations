
=begin
Takes a word as the first argument and then an array of valid substrings
(your dictionary) as the second argument. Returns a hash listing each 
substring that was found in the original string and how many times it 
was found.
=end

def dictionary_search(words)
    hash_results = Hash.new(0)
    puts "Search words separated by spaces: "
    search_list = gets.chomp.to_s.split(" ")
    search_list.each do |searched|
        count = 0
        words.each do |word|
            if word == searched
                count += 1
            end
        end
        hash_results.merge! searched => count
    end
    puts hash_results
end

puts "Words for dictionary separated by spaces: "
words = gets.chomp.to_s.split(" ")
dictionary_search(words)
