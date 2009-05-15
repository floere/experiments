# Y combinator
# (lambda (f x) (f f x))

X = ->(x, generator) do
  ->(*args) do
    generator.call(x.call(x, generator)).call(*args)
  end
end

Y = ->(generator) { X[X, generator] }

factorial = ->(callback) do
    ->(arg) { arg.zero? ? 1 : arg*callback[arg-1] }
end

puts Y[factorial][5]