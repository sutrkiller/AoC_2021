@time begin
    input = open(f->read(f, String), "day-4/input4.txt")
    parts = split(input, "\n\n"; keepempty=false)
    numbers = [parse(Int32, n) for n in split(parts[1], ','; keepempty=false)]

    results = fill((index=0, score = 0), lastindex(parts) - 1)
    for (bI, bS) in enumerate(parts[2:end])
        B = hcat([map(x -> parse(Int32, x), y) 
                for y in [split(y, ' '; keepempty=false) 
                    for y in split(bS, "\n"; keepempty=false)
                ]]...)
        
        for (nI, n) in enumerate(numbers)
            for i in findall(x -> x == n, B)
                B[i] = -1
            end
            ((any(count(==(-1), B, dims=1) .== size(B)[1]) 
                || any(count(==(-1), B, dims=2) .== size(B)[2]))
            && (results[bI] = (index = nI, score= n * (sum(B)+count(==(-1),B))); break))
        end
    end

    sorted = sort(results; by= x -> x.index)
    println("First: ", first(sorted).score)
    println("Last: ", last(sorted).score)
end