#Решение квадратного уравнения
puts "Программа решает квадратное уровнение."
print "Введите первый коэффициент: "
a = gets.chomp.to_i
print "Введите второй коэффициент: "
b = gets.chomp.to_i
print "Введите третий коэффициент: "
c = gets.chomp.to_i

#Вычисляем дискриминант
d = b**2 - 4 * a * c
D = Math.sqrt(d)

#Выводим результат
puts "Корней нет, дискриминант = #{d}" if d < 0
puts "Один корень x = #{- b/(2 * a)}, дискриминант = #{d}" if d == 0
puts "Два корня, x1 = #{(- b + D)/(2 * a)}, x2 = #{(- b - D)/(2 * a)}, дискриминант = #{d}" if d > 0
