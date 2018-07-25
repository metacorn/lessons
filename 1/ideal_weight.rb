print "Please enter your name: "
user_name = gets.chomp
print "Please enter your height (in cm): "
user_height = gets.to_i
ideal_weight = user_height - 110
if ideal_weight < 0
  puts "#{user_name}, your weight is ideal already!"
else
  puts "#{user_name}, your ideal weight is #{ideal_weight} kg."
end
