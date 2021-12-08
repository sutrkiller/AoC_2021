input = open(f->read(f, String), "input1.txt")
numbers = parse.(Int, split(input, "\n"; keepempty=false))

# Part 1
println(count(diff(numbers) .> 0))

# Part 2
println(sum([numbers[i-3] < numbers[i] for i=4:lastindex(numbers)]))