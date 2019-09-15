year_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

print 'Введите год: '
year = gets.chomp.to_i
print 'Введите месяц: '
month = gets. chomp.to_i
print 'Введите день: '
day = gets.chomp.to_i

year_month[1] = 29 if (year % 4).zero? && !(year % 100).zero? || (year % 400).zero?

offset = month - 2
num = day

until offset.negative?
  num += year_month[offset]
  offset -= 1
end

puts year_month.inspect, num
