@time begin
    input = open(f->read(f, String), "day-14/input14.txt")
    parts = split(input, "\n\n"; keepempty=false)
    
    text = parts[1]
    rules = Dict(split(parts[2], '\n';keepempty=false) .|> x -> split(x, " -> "))

    counts = Dict{String, Int}([(x[1] => 0) for x in rules])
    totalCounts = copy(counts)
    letterCounts = Dict([(string(x) => count(c -> c == x, text)) for x='A':'Z'])

    for i=2:lastindex(text)
        p = text[i-1:i]
        p in keys(counts) && (counts[p] += 1)
    end
    
    for i=1:40 
        for p in counts 
            p[2] == 0 && continue

            rule = rules[p[1]]
            letterCounts[rule] += p[2]
            newA = p[1][1:1] * rule
            newB = rule * p[1][2:2]

            newA in keys(totalCounts) && (totalCounts[newA] += p[2])
            newB in keys(totalCounts) && (totalCounts[newB] += p[2])
        end
        global counts = copy(totalCounts)
        global totalCounts = Dict{String, Int}([(x[1] => 0) for x in rules])
    end

    max = maximum(values(letterCounts))
    min = minimum(x -> x > 0 ? x : typemax(Int), values(letterCounts))
    println(max - min)
end