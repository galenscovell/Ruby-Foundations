
=begin 
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.
=end

puts "This program will find the sum of all multiples of 3 or 5 below a given value."

print "\nPlease enter a whole number limit: "
limit = gets.chomp.to_i

sum, i = 0, 0
while (i < limit)
    if (i % 3 == 0 || i % 5 == 0)
        sum += i
    end
    i += 1
end
puts sum