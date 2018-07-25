print "Please enter the length of the first side of the triangle: "
a = gets.to_f
print "Please enter the length of the second side of the triangle: "
b = gets.to_f
print "Please enter the length of the third side of the triangle: "
c = gets.to_f

sides = [a, b, c].sort {|x, y| y <=> x }

a = sides[0]
b = sides[1]
c = sides[2]

if a**2 == b**2 + c**2
  puts "The triangle is right!"
  if a == b || b == c
    puts "The triangle is isosceles!"
  end
end
