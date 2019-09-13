hh = {}
num = 1

(:a..:z).each do |i|
  hh[i] = num if i[/[aeiou]/]
  num += 1
end

puts hh.inspect
