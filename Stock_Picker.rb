
=begin
Takes a list of days with stock prices and calculates the best days to 
buy and sell for maximal profit. You need to buy before you can sell!
=end

def stock_picker(prices)
  min_to_max = prices.sort
  max_to_min = prices.sort.reverse
  i = 0
  while i < prices.size
    current_min = min_to_max[0 + i]
    current_max = max_to_min[0 + i]
    if prices.index(current_min) < prices.index(current_max)
      puts "Buy on day #{prices.index(current_min) + 1}, sell on day #{prices.index(current_max) + 1}"
      puts "Profit = $#{current_max - current_min}"
      break
    end
  i += 1
  end
end

price = 1
prices_array = []
day = 1
while price != 0
  puts "Enter the stock price for day #{day} (0 to finish)"
  price = gets.chomp.to_i
  if price != 0
    prices_array << price
    day += 1
  end
end
puts prices_array.inspect
stock_picker(prices_array)