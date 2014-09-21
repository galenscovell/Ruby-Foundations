
=begin
The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143?
=end

def is_prime?(num)
  (2..(num-1)).each do |i|
    if num % i == 0
      return false
    end
  end
  return true
end

puts "\nThis program will compute the largest prime factor of a given number."
puts "Enter a whole number: "
chosen_number = gets.chomp.to_i
chosen_array = [*1..chosen_number]
prime_list = []

begin_time = Time.now
chosen_array.each do |i|
  if is_prime?(i)
    prime_list << i
  end
end

puts "\nLargest prime factor of #{chosen_number} is #{prime_list.max}"
puts "Runtime: #{Time.now - begin_time} seconds\n"
