print "Please enter the length of the first side of the triangle: "
a = Integer(gets.chomp)
print "Please enter the length of the second side of the triangle: "
b = Integer(gets.chomp)
print "Please enter the length of the third side of the triangle: "
c = Integer(gets.chomp)

if b < c # вычисляем большее из b и c, большее записываем в b, меньшее в c
	temp = c
	c = b
	b = temp
end

if a < b # по тому же принципу выстраиваем "по росту" a и b
	temp = b
	b = a
	a = temp
end

if b < c # делаем то же ещё раз с b и c - теперь a, b и с идут по убыванию длин
	temp = c
	c = b
	b = temp
end

if a * a == b * b + c * c
	puts "The triangle is right!"
end

if a == b || b == c
	puts "The triangle is isosceles!"
end
