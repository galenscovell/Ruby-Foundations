
# Basic fizzbuzz algorithm. Useful to be able to tool out, I'd imagine.


def fizz_buzz (arr)
  arr.each do |n|
    puts "FizzBuzz: #{n}" if n % 3 == 0 && n % 5 == 0
    puts "Fizz: #{n}" if n % 3 == 0
    puts "Buzz: #{n}" if n % 5 == 0
  end
end

puts "Up to what value?"
limit = gets.chomp.to_i
value_array = *(1..limit)
fizz_buzz(value_array)