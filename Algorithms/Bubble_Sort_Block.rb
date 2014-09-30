
# Bubble sort that accepts blocks, compares word length

def bubble_sort_by(array)
  sorted_array =[]
  start = Time.now
  while array.size > 0
    i = 0
    while i < array.size - 1
      if yield(array[i], array[i+1]) < 0
        array[i], array[i+1] = array[i+1], array[i]
      end
      i += 1
    end
    sorted_array << array[-1]
    array.delete_at(-1)
  end
  p sorted_array.reverse
  running_time = Time.now - start
  puts "Runtime: #{running_time}"
end      

puts "Enter text (separated by spaces, no special characters): "
word_list = gets.chomp.split(" ")

bubble_sort_by(word_list) do |left, right|
  right.length - left.length
end
