puts "Enter the day:"
day = gets.to_i
puts "Enter the month:"
month = gets.to_i
puts "Enter the year:"
year = gets.to_i

# хэш со значениями кол-ва дней в месяце невисокосного года

days = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}

# вычисление високосности года
# три условия, т.к. if + elsif + else здесь не сработает

leap = false

if year % 4 == 0
  leap = true
end

if year % 100 == 0
  leap = false
end

if year % 400 == 0
  leap = true
end

if leap
  days[2] = 29
end

# проверка введённой даты на корректность, сделано через 3 условия для читаемости

error_message = "You entered an incorrect date!"

if month > 12 # кол-во месяцев
  puts error_message
  exit
end

if day > days[month] # кол-во дней
  puts error_message
  exit
end

# вычисление порядкового номера дня в году

date_number = 0

(1..(month - 1)).each do |m|
  date_number += days[m]
end

date_number += day

puts "The number of date is #{date_number}!"
