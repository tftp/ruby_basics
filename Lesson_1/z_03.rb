#Прямоугольный треугольник
a = []
print "Ведите 1 сторону треугольника: "
a << gets.chomp.to_i
print "Ведите 2 сторону треугольника: "
a << gets.chomp.to_i
print "Ведите 3 сторону треугольника: "
a << gets.chomp.to_i

a.sort!

#Определение прямоугольности по теореме Пифагора и вывод результата
puts "Теугольник прямоугольный" if a[2]**2 == a[0]**2 + a[1]**2

#Определение равностороннего треугольника
puts "Треугольник равносторонний" if a[0] == a[1] && a[0] == a[2]

#Определение равнобедренного треугольника
puts "Треугольник равнобедренный" if a[0] == a[1] || a[0] == a[2] || a[1] == a[2]
