@time begin
    input = readlines("day-12/input12.txt")
    lines = split.(input, '-')

    nodenames = unique(reduce(vcat,lines))
    startindex = 0
    endindex = 0
    smallnodes = Vector{Int}()
    for i=1:length(nodenames)
        n = nodenames[i]
        n == "start" && (global startindex = i;continue)
        n == "end" && (global endindex = i;continue)
        islowercase(n[1]) && push!(smallnodes, i)
    end
    
    edges = Dict{Int,Vector{Int}}()
    for line in lines
        l,r = [findfirst(==(line[1]), nodenames), findfirst(==(line[2]), nodenames)]
        l != endindex && r != startindex && (l ∈ keys(edges) ? push!(edges[l],r) : (edges[l] = [r]))
        r != endindex && l != startindex && (r ∈ keys(edges) ? push!(edges[r],l) : (edges[r] = [l]))
    end

    function count_paths(node::Int, encountered_small::Set{Int})
        node == endindex && return 1
        count = 0
        for next in edges[node]
            next ∈ smallnodes && 
                (next ∈ encountered_small ? continue : push!(encountered_small, next)) 
            count += count_paths(next, encountered_small)
            pop!(encountered_small, next, 0)
        end
        count
    end

    function count_paths(node::Int, encountered_once::Set{Int}, encountered_twice::Set{Int})
        node == endindex && return 1
        count = 0
        for next in edges[node]
            next ∈ smallnodes && 
                (next ∈ encountered_once ? 
                    (length(encountered_twice) > 0 ? continue : push!(encountered_twice, next)) : 
                    push!(encountered_once, next)) 
            count += count_paths(next, encountered_once, encountered_twice)
            pop!(encountered_twice, next, 0) == 0 && pop!(encountered_once, next, 0)
        end
        count
    end

    paths = count_paths(startindex, Set{Int}())
    println(paths)

    paths = count_paths(startindex, Set{Int}(), Set{Int}())
    println(paths)
end