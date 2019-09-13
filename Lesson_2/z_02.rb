
arr = []
nach = 10
kon = 100

i = nach
loop do
  arr << i
  i += 5
  break if i > kon
end

print arr.inspect