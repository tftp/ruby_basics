hh = {}
Vowel = /[aeiou]/

(:a..:z).each.with_index(1) do |letter, i|
  hh[letter] = i if letter[Vowel]
end

puts hh.inspect
