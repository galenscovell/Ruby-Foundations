
=begin
Caesar cipher, each letter in the plaintext is replaced by a letter
some fixed number of positions up the alphabet. For example, with a
left shift of 3, D would be replaced by G, E would become H, and so on
=end

def encryption_method(input, key)
  letter_array = input.split("")
  encrypted_array = []

  letter_array.each do |letter|
    ascii_code = letter.ord
    ascii_shifted = ascii_code + key
        
    if ascii_code.between?(97,122) # lower case characters
      if ascii_shifted > 122
        encrypted_array << (ascii_shifted - 26).chr
      else
        encrypted_array << ascii_shifted.chr
      end
    elsif ascii_code.between?(65,90) # upper case characters
      if ascii_shifted > 90
        encrypted_array << (ascii_shifted - 26).chr
      else
        encrypted_array << ascii_shifted.chr
      end
    else
      encrypted_array << letter # " ", !, ? etc not converted
    end
  end
  puts encrypted_array.join
end

code_key = 0
while code_key <= 0 || code_key > 25
  puts "Enter the key to use for encryption (1-25): "
  code_key = gets.chomp.to_i
end
puts "Enter the text to be encrypted: "
text = gets.chomp
encryption_method(text, code_key)

