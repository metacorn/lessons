letters = ("a".."z").to_a
vowels = "aeiouy"
vowels_hash = {}
letters.each_with_index do |letter, number|
  if vowels.include? letter
    vowels_hash[letter.to_sym] = number
  end
end

puts vowels_hash
