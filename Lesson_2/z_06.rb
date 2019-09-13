basket = {}

loop do
  print 'Введите название товара: '
  item = gets.chomp
  break if item == 'stop'

  print 'Введите цену за еденицу: '
  price = gets.chomp.to_f
  print 'Введите количество: '
  quantity = gets.chomp.to_f
  basket[item] = { price: price, quantity: quantity }
end

sum_all_item = 0
basket.each do |item, price_quantity|
  print "Название: #{item}, цена: #{price_quantity[:price]},  "
  print "количество: #{price_quantity[:quantity]}. "
  sum_item = price_quantity[:price] * price_quantity[:quantity]
  sum_all_item += sum_item
  puts "Итого по товару #{item}: #{sum_item}"
end
puts "Общая сумма товара: #{sum_all_item}"
