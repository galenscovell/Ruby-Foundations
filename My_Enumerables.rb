
# Re-creation of enumerable methods using Ruby basics

module Enumerable

  # Iterate through given array returning each value
  def my_each
    return self unless block_given?
    for e in self
      yield(e)
    end
    return self
  end

  # Use iteration to create hash with value and index
  def my_each_with_index
    return self unless block_given?
    hash = Hash.new(0)
    for h in self
      yield h, self.index(h)
      hash.merge! self.index(h) => h
    end
    return hash
  end

  # Iterate through and select items given in block
  def my_select
    return self unless block_given?
    new_arr = []
    self.my_each { |s| new_arr << s if yield(s) }
    return new_arr
  end

  # Check if all items follow block conditions
  def my_all?
    return self unless block_given?
    for a in self
      if !yield(a)
        return false
      end
    end
    return true
  end

  # Check if any items follow block conditions
  def my_any?
    return self unless block_given?
    for a in self
      if yield(a)
        return true
      end
    end
    return false
  end

  # Check if block conditions are never true for item set
  def my_none?
    return self unless block_given?
    for n in self
      if yield(n)
        return false
      end
    end
   return true
  end

  # Returns count of items meeting block conditions
  def my_count
    return self unless block_given?
    count = 0
    for i in self
      if yield(i)
        count += 1
      end
    end
    return count
  end

  # Apply block through iteration
  def my_map
    return self unless block_given?
    mapped = []
    for m in self
      mapped << yield(m)
    end
    return mapped
  end

  # Combine all items using block conditions
  def my_inject (initial = self.first)
    return self unless block_given?
    memo = initial
    self.my_each { |e| memo = yield(memo, e) }
    return memo
  end

end # End module


puts "Enter list separated by spaces: "
arr = gets.chomp.split(" ")


# Testing Below!

# arr.my_each { |n| p n }
# arr.my_each_with_index { |val, idx| }
# arr.my_select { |n| n.to_i % 2 == 0 }
# arr.my_all? { |x| x.to_i > 0 }
# arr.my_any? { |x| x.to_i > 5 }
# arr.my_none? { |x| x.to_i < 0 }
# arr.my_count { |x| x.to_i > 3 }
# arr.my_map { |y| y.to_i ** 2 }
# arr.my_inject(0) { |result, element| result.to_i + element.to_i }
# arr.my_inject(1) { |product, e| product.to_i * e.to_i }