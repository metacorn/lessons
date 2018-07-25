print "Please enter the length of the first side of the triangle: "
a = gets.to_f
print "Please enter the length of the second side of the triangle: "
b = gets.to_f
print "Please enter the length of the third side of the triangle: "
c = gets.to_f

sides = [a, b, c].sort

cath1 = sides[0]
cath2 = sides[1]
hypo = sides[2]

if hypo**2 == cath1**2 + cath2**2
	puts "The triangle is right!"
	if cath1 == cath2 || cath2 == hypo
		puts "The triangle is isosceles!"
	end
end
