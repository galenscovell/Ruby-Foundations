

# A palindromic number reads the same both ways. 
# The largest palindrome made from the product of two 
# 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of 
# two 3-digit numbers.


puts "Number of digits: "
digits = gets.chomp.to_i
low_end = '1' + '0' * (digits - 1)
high_end = '1' + '0' * digits

pal_arr = []
(low_end..high_end).each do |n|
  (n..high_end).each do |m|
    x = n.to_i * m.to_i
    if x.to_s == x.to_s.reverse
      pal_arr << x
    end
  end
end
puts pal_arr.max
