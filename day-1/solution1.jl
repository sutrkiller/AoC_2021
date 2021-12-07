input = open(f->read(f, String), "input1.txt")
numbers = [parse(Int, n) for n in split(input, "\n"; keepempty=false)]

# Part 1
println(sum([numbers[i-1] < numbers[i] for i=2:lastindex(numbers)]))

# Part 2
println(sum([numbers[i-3] < numbers[i] for i=4:lastindex(numbers)]))