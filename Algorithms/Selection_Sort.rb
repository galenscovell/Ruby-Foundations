
# Iterates through a list of integers, finds the minimum value and places it at proper sorted placement at beginning of array.

def selection_sort(arr)
  (0..arr.length-2).each do |num|
    min_idx = num
    ((num+1)...arr.length).each do |z| 
      if arr[z] < arr[min_idx]
        min_idx = z 
      end
    end
    arr[num], arr[min_idx] = arr[min_idx], arr[num]
  end
  p arr
end

puts "Enter a list of integers to be sorted (separated by spaces): "
list = gets.split.map { |x| x.to_i }
selection_sort(list)