hh = {}
num = 1
Vowel = /[aeiou]/

(:a..:z).each do |i|
  hh[i] = num if i[Vowel]
  num += 1
end

puts hh.inspect
