print "Please enter the length of the first side of the triangle: "
a = gets.to_f
print "Please enter the length of the second side of the triangle: "
b = gets.to_f
print "Please enter the length of the third side of the triangle: "
c = gets.to_f

sides = [a, b, c].sort

<<<<<<< HEAD
catet1 = sides[0]
catet2 = sides[1]
hypo = sides[2]

if hypo**2 == catet1**2 + catet2**2
	puts "The triangle is right!"
end

if (hypo**2 == catet1**2 + catet2**2) && (catet1 == catet2 || catet2 == hypo)
	puts "The triangle is right and isosceles!"
=======
cath1 = sides[0]
cath2 = sides[1]
hypo = sides[2]

if hypo**2 == cath1**2 + cath2**2
	puts "The triangle is right!"
	if cath1 == cath2 || cath2 == hypo
		puts "The triangle is isosceles!"
	end
>>>>>>> f66f477d04d1cdc37f19e3d0ac4d0243d8bda3d2
end
