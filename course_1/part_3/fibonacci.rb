a = 1
array_f = []
array_f.push a

until a > 100
  array_f.push a
  n = array_f.size
  a = array_f.at(n - 1) + array_f.at(n - 2)
end

puts array_f
