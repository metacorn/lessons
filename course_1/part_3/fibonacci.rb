fibo_number = 1
fibo_sequence = [1]

until fibo_number > 100
  fibo_sequence.push(fibo_number)
  fibo_number = fibo_sequence[-1] + fibo_sequence[-2]
end

puts fibo_sequence
