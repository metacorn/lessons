order = {}
total_value = 0
item_name = ""

until item_name == "Stop"
  puts "Enter the name of item:"
  item_name = gets.chomp.capitalize
  break if item_name == "Stop"
  puts "Enter cost per unit, $:"
  item_cost = gets.to_f
  puts "Enter the quantity of item:"
  item_quantity = gets.to_f
  item_data = {
    item_cost: item_cost,
    item_quantity: item_quantity
  }
  order[item_name] = item_data
end

if order.empty?
  puts "\nThere are no goods in your cart!"
else
  puts "\nYOUR CART:"
  order.each do |name, item_data|
    item_value = item_data[:item_cost] * item_data[:item_quantity]
    puts "#{name}, #{item_data[:item_quantity]} x #{item_data[:item_cost]}$ = #{item_value}$."
    total_value += item_value
  end
end

puts "Total value: " + total_value.to_s + "$."
