fibonachy = [0, 1]
i = 1
next_num = 1

while next_num < 100
  fibonachy << next_num
  next_num = fibonachy[i] + fibonachy[i + 1]
  i += 1
end

puts fibonachy.inspect
