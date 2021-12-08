input = open(f-> read(f, String), "input8.txt");
lines =  [l for l in split(input, '\n'; keepempty = false)]

counts = 0
output = 0;

for matches in [[sort([a for a in s.match]) for s in eachmatch(r"(\w+)+", line)] for line in lines]
    # Part 1
    global counts += sum(s -> (lastindex(s) in [2, 4 ,3, 7]), matches[11:end])
    
    # Part 2
    config::Vector{Vector{Char}} = [[] for i in 1:10]
    
    for m in sort(matches[1:10], by=length)
        length(m) == 2 && (config[2] = m; continue)
        length(m) == 3 && (config[8] = m; continue)
        length(m) == 4 && (config[5] = m; continue)
        length(m) == 7 && (config[9] = m; continue)

        if (length(m) == 5)
            lastindex(intersect(m, config[2])) == 2 && (config[4] = m; continue)
            lastindex(intersect(m, config[5])) == 2 && (config[3] = m; continue)
            config[6] = m
        end

        if (length(m) == 6) 
            lastindex(intersect(m, config[5])) == 4 && (config[10] = m; continue)
            lastindex(intersect(m, config[2])) == 1 && (config[7] = m; continue)
            config[1] = m
        end 
    end
        
    for (i,m) in enumerate(reverse(matches[11:end]))
        global output += (findfirst(x -> m == x, config) -1) * (10 ^ (i-1))
    end
end

println(counts)
println(output)