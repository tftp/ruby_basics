# Solving the quadratic equation
puts 'Программа решает квадратное уровнение.'
print 'Введите первый коэффициент: '
a = gets.chomp.to_i
print 'Введите второй коэффициент: '
b = gets.chomp.to_i
print 'Введите третий коэффициент: '
c = gets.chomp.to_i

# Calculate the discriminant
d = b**2 - 4 * a * c

# Output the result
puts "Корней нет, дискриминант = #{d}" if d.negative?
puts "Один корень x = #{- b / (2 * a)}, дискриминант = #{d}" if d.zero?
if d.positive?
  D = Math.sqrt(d)
  puts "Два корня, x1 = #{(- b + D) / (2 * a)}, x2 = #{(- b - D) / (2 * a)},
  дискриминант = #{d}"
end
