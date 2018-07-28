puts "Enter the day:"
day = gets.to_i
puts "Enter the month:"
month = gets.to_i
puts "Enter the year:"
year = gets.to_i

# массив со значениями кол-ва дней в месяце невисокосного года

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# добавлление дня в февраль високосного года

days[1] = 29 if (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)

# проверка введённой даты на корректность

if (month > 12) || (day > days[month - 1])
  puts "You entered an incorrect date!"
  exit
end

# вычисление порядкового номера дня в году

date_number = day

(0..(month - 2)).each { |months_before| date_number += days[months_before] }

puts "The number of date is #{date_number}!"
