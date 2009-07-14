def fact last, first = 1
  d = last - first
  if d.zero?
    first
  else
    mid = first + d / 2
    fact(mid, first) * fact(last, mid + 1)
  end
end

p fact(1)
p fact(5)
p fact(1_000)
p fact(10_000)
p fact(20_000)