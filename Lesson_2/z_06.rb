# item, price, quantity

basket = {}

loop do
  print "Введите название товара: "
  item = gets.chomp
  break if item == "stop"
  print "Введите цену за еденицу: "
  price = gets.chomp.to_f
  print "Введите количество: "
  quantity = gets.chomp.to_f

  basket[item] = {:price => price, :quantity => quantity}
end

puts basket.inspect