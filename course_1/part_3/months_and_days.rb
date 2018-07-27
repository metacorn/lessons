months = {
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

months_30 = months.select do |month, days|
  days == 30
end

months_30.each_key do |month|
  puts month.to_s
end
