@time begin
    input = open(f->read(f, String), "day-11/input11.txt")
    ps(x::Array{Char}) = parse.(Int, x)'
    numbers = vcat((split(input, "\n"; keepempty=false) .|> collect .|> ps)...)

    flashes = 0
    all_flashed = -1
    step = 1
    while all_flashed < 1 || step <= 100
        numbers .+= 1
        toFlash = Set{CartesianIndex{2}}(findall(>(9), numbers))
        flashed = Set{CartesianIndex{2}}([])
        
        while length(toFlash) > 0
            I = pop!(toFlash)
            I in flashed && continue
            numbers[I] = 0;
            push!(flashed, I)
        
            for I2 in setdiff(CartesianIndices((I[1]-1:I[1]+1,I[2]-1:I[2]+1)), flashed)
                !checkbounds(Bool, numbers, I2) && continue
                numbers[I2] += 1
                numbers[I2] > 9 && (push!(toFlash, I2))
            end
        end

        step <= 100 && (global flashes += length(flashed))
        length(flashed) == length(numbers) && (global all_flashed = step)
        global step += 1
    end
    println(flashes)
    println(all_flashed)
end