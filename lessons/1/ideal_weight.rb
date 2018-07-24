print "Please enter your name: "
user_name = gets.chomp
print "Please enter your height (in cm): "
user_height = Integer(gets.chomp)
ideal_weight = user_height - 110
if ideal_weight < 0
	puts "Your weight is ideal already!"
else
	puts "Your ideal weight is #{ideal_weight} kg."
end