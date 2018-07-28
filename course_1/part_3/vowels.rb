letters = ("a".."z").to_a
vowels = "aeiouy"
vowels_hash = {}
letters.each_with_index do |letter, number|
    vowels_hash[letter.to_sym] = number + 1 if vowels.include? letter
end

puts vowels_hash
