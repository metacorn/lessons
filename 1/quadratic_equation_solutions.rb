print "Please enter a (of a * x**2 + b * x + c = 0): "
a = gets.to_f
print "Please enter b (of a * x**2 + b * x + c = 0): "
b = gets.to_f
print "Please enter c (of a * x**2 + b * x + c = 0): "
c = gets.to_f

d = b**2 - 4 * a * c

if d < 0
	puts "Discriminant equals #{d}."
	puts "This equation has no solution!"
elsif d == 0
	x = -1 * b / (2 * a)
	puts "Discriminant equals #{d}."
	puts "The solution is #{x}."
else
	d_sqrt = Math.sqrt(d)
	x1 = (- b + d_sqrt) / (2 * a)
	x2 = (- b - d_sqrt) / (2 * a)
	puts "Discriminant equals #{d}."
	puts "The solutions are #{x1} and #{x2}."
end
