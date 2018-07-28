months_of_year = {
  january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  jule: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31
}

months_of_year.each do |month, days_in_month|
  puts "#{month}: #{days_in_month}" if days_in_month == 30
end
