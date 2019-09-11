# Right triangle
a = []
print 'Ведите 1 сторону треугольника: '
a << gets.chomp.to_i
print 'Ведите 2 сторону треугольника: '
a << gets.chomp.to_i
print 'Ведите 3 сторону треугольника: '
a << gets.chomp.to_i

a.sort!

# Determination of Squareness by Pythagorean theorem
puts 'Теугольник прямоугольный' if a[2]**2 == a[0]**2 + a[1]**2

# Definition of an equilateral triangle
puts 'Треугольник равносторонний' if a[0] == a[1] && a[0] == a[2]

# Definition of an isosceles triangle
if a[0] == a[1] || a[0] == a[2] || a[1] == a[2]
  puts 'Треугольник равнобедренный'
end
