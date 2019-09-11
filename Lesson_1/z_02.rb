# Triangle area calculation program
print 'Введите значение основания треугольника: '
a = gets.chomp.to_f
print 'Введите значение высоты треугольника: '
h = gets.chomp.to_f

# Next, calculate the area of the triangle s
s = a * h / 2
puts "Площадь треугольника равна значению #{s}"
