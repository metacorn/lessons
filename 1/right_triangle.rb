print "Please enter the length of the first side of the triangle: "
a = gets.to_f
print "Please enter the length of the second side of the triangle: "
b = gets.to_f
print "Please enter the length of the third side of the triangle: "
c = gets.to_f

if a == b && b == c
	exit
end

sides = [a, b, c].sort

catet1 = sides[0]
catet2 = sides[1]
hypo = sides[2]

if hypo**2 == catet1**2 + catet2**2
	puts "The triangle is right!"
end

if (hypo**2 == catet1**2 + catet2**2) && (catet1 == catet2 || catet2 == hypo)
	puts "The triangle is right and isosceles!"
end
