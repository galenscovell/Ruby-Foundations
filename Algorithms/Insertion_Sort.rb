
# Insertion sort iterates, consuming one input element each repetition, and growing a  
# sorted output list. Each iteration, insertion sort removes one element from the input 
# data, finds the location it belongs within the sorted list, and inserts it there.    
# It repeats until no input elements remain.

def insertion_sort(arr)
  1.upto(arr.length - 1) do |n|
    current = arr[n]
    m = n - 1
    while m >= 0 && arr[m] > current
      arr[m+1] = arr[m]
      m -= 1
    end
    arr[m+1] = current
  end
  p arr
end

puts "Enter a list of integers to be sorted (separated by spaces): "
list = gets.split.map { |x| x.to_i }
insertion_sort(list)