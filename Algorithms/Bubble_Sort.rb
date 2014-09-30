
=begin
Your basic bubble sort algorithm!
Starting from the beginning of the list, compares every adjacent pair,
swaps their position if they are not in the right order (the latter one
is smaller than the former one). After each iteration, one less element 
(the last one) is needed to be compared until there are no more 
elements left to be compared.
=end

def bubble_sort(array)
  sorted_array =[]
  start = Time.now
  while array.size > 0
    i = 0
    while i < array.size - 1
      if array[i] > array[i+1]
        array[i], array[i+1] = array[i+1], array[i]
      end
      i += 1
    end
    p array
    sorted_array << array[-1]
    array.delete_at(-1)
  end
  p sorted_array.reverse
  running_time = Time.now - start
  puts "Runtime: #{running_time}"
end      

puts "Enter an array of integers to be sorted (separated by spaces): "
integer_list = gets.split.map { |x| x.to_i }
bubble_sort(integer_list)