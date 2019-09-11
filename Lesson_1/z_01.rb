#Программа расчитывает и выводит идеальный вес
print "Введите свое имя: "
name = gets.chomp
print "Введите свой рост: "
growth = gets.chomp.to_i
ideal_growth = growth - 110
if ideal_growth > 0
  puts "#{name}, ваш идеальный вес: #{ideal_growth} кг."
else
  puts "#{name}, ваш вес уже оптимальный!"
end
