@time begin
    input = open(f->read(f, String), "day-9/input9.txt")
    numbers = vcat((split(input, "\n"; keepempty=false) .|> collect .|> x -> parse.(Int, x)')...)

    function findbasinsize!(point::Tuple{Int,Int})
        visited = Set{Tuple{Int, Int}}([])    
        found = Set{Tuple{Int, Int}}([point])
        s = 0;
        while length(found) > 0
            p = pop!(found)
            y,x = p
            #println(numbers[y,x])
            !checkbounds(Bool, numbers, y,x) && continue
            numbers[y, x] == 9 && continue
            p ∈ visited && continue
        
            s += 1
            push!(found, (y-1,x), (y,x-1), (y+1,x), (y,x+1))
            push!(visited, p)
        end
        s
    end

    minimums = [];
    risk = 0;
    basinSizes = []
    for y in 1:size(numbers)[1]
        for x in 1:size(numbers)[2]
            n = numbers[y,x]

            # Part 1 
            (!checkbounds(Bool, numbers, y-1, x) || n < numbers[y-1,x]) &&
            (!checkbounds(Bool, numbers, y, x-1) || n < numbers[y,x-1]) &&
            (!checkbounds(Bool, numbers, y, x+1) || n < numbers[y, x+1]) &&
            (!checkbounds(Bool, numbers, y+1, x) || n < numbers[y+1, x]) &&
            (global risk += n+1; push!(minimums, (y,x)))
        end
    end

    # Part 2
    for p in minimums
        push!(basinSizes, findbasinsize!(p))
    end

    println(risk)
    println(reduce(*,sort(basinSizes)[end-2:end]))
end