# Несколько способов со step

arr = []
(10..100).step(5){|i| arr << i}
puts arr.inspect

# Можно ещё так. И так и так оч. интересно. Я не знал, что так можно!

arr = []
arr = (10..100).step(5).to_a
puts arr.inspect
