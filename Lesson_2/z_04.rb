hh = {}
num = 1

for i in (:a..:z)
  hh[i] = num if i[/[aeiou]/]
  num += 1
end

puts hh.inspect