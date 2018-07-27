letters = ("a".."z").to_a
n = letters.size
vowels = "aeiouy"
vowels_hash = Hash.new
for i in (0..letters.size - 1) do
  if vowels.include? letters[i]
    vowels_hash[letters[i].to_sym] = i
  end
end

puts vowels_hash
