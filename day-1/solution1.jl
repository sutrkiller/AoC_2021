@time begin
    input = open(f->read(f, String), "day-1/input1.txt")
    numbers = parse.(Int, split(input, "\n"; keepempty=false))

    # Part 1
    println(count(diff(numbers) .> 0))

    # Part 2
    println(sum(numbers[1:end-3] .< numbers[4:end]))
end