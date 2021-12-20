@time begin
    input = open(f->read(f, String), "day-15/input15.txt")
    ps(x::Array{Char}) = parse.(Int, x)'
    numbers = vcat((split(input, "\n"; keepempty=false) .|> collect .|> ps)...)
    
    all = []
    for x=0:4
        columns = []
        for y=0:4 
            n = ((copy(numbers) .+ (y+x-1)) .%9) .+ 1
            push!(columns,n)
        end
        push!(all,reduce(vcat, columns))
    end
    numbers = reduce(hcat, all)

    distances  = fill(typemax(Int), size(numbers)[1], size(numbers)[2])
    distances[1,1] = 0
    unvisited = [CartesianIndex(1,1)]
    visited = Set([])

    while length(unvisited) > 0
        local min= minimum(f -> distances[f], unvisited)
        minI = findfirst(x -> distances[x] == min, unvisited)
        V = popat!(unvisited, minI)
        push!(visited, V)

        adj = [CartesianIndex(V[1], V[2]-1), CartesianIndex(V[1], V[2]+1),CartesianIndex(V[1]-1, V[2]), CartesianIndex(V[1]+1, V[2])]
        for I in setdiff(adj, visited)
            !checkbounds(Bool, numbers, I) && continue
            newD = distances[V] + numbers[I]
            if (newD < distances[I])
                distances[I] = newD
            end
            I ∉ unvisited && push!(unvisited, I)
        end
    
        V == CartesianIndex(size(numbers)[1], size(numbers)[2]) && break
    end

    println(distances[lastindex(distances)])
end