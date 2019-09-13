fibonachy = [0, 1]
i = 0
loop do
  next_num = fibonachy[i] + fibonachy[i + 1]
  break if next_num > 100
  fibonachy << next_num
  i += 1
end

puts fibonachy.inspect