using DataStructures

@time begin
    input = readlines("day-15/input15.txt")   
    mp(x::String) = parse.(Int, split(x,""))'
    adj_all = CartesianIndices((-1:1,-1:1))[2:2:8]
    I = reduce(vcat, map(mp, input))

    function dijkstra(istart::CartesianIndex{2}, iend::CartesianIndex{2}, M::Matrix{Int})
        D = fill(typemax(Int), size(M)...)
        D[istart] = 0
        V = falses(size(M)...)
        h = BinaryHeap{Tuple{Int, CartesianIndex{2}}, Base.ForwardOrdering}([(0, istart)])

        while !isempty(h)
            node = pop!(h)[2]
            node == iend && break
            V[node] = true
            for adjacent in adj_all
                next = adjacent + node
                (!checkbounds(Bool, M, next) || V[next]) && continue
                new_distance = D[node] + M[next]
                new_distance < D[next] && (D[next] = new_distance;push!(h, (new_distance, next)))
            end
        end
        D[iend]
    end

    # Part 1
    risk = dijkstra(CartesianIndex(1,1), CartesianIndex(size(I)...), I)
    println(risk)

    # Part 2
    T = vcat((mod1.(I .+ i, 9) for i = 0:4)...)
    I = hcat((mod1.(T .+ i, 9) for i = 0:4)...)
    risk = dijkstra(CartesianIndex(1,1), CartesianIndex(size(I)...), I)
    println(risk)
end