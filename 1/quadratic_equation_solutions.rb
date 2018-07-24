print "Please enter a (of a*x^2+b*x+c=0): "
a = Integer(gets.chomp)
print "Please enter b (of a*x^2+b*x+c=0): "
b = Integer(gets.chomp)
print "Please enter c (of a*x^2+b*x+c=0): "
c = Integer(gets.chomp)

d = b ** 2 - 4 * a * c

if d < 0
	puts "Discriminant equals #{d}."
	puts "This equation has no solution!"
elsif d == 0
	puts "Discriminant equals #{d}."
	puts "The solution is #{-1 * b / (2 * a)}."
else
	puts "Discriminant equals #{d}."
	puts "The solutions are #{(Math.sqrt(d) - b) / (2 * a)} and #{(-1 * Math.sqrt(d) - b) / (2 * a)}."
end