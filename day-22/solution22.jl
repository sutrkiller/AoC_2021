@time begin
    input = readlines("day-22/input22.txt")
    split.(input, '=')[1]
    iter = match.(r"^(on|off)" * Regex(".*?=(-?\\d+)\\.\\.(-?\\d+)"^3), input)
 
    ranges = Vector{Tuple{Bool, Vector{UnitRange{Int}}}}()
    for l in iter
        p = parse.(Int, l.captures[2:end]) .+ 51
        push!(ranges, (l[1] == "on", [p[1]:p[2], p[3]:p[4], p[5]:p[6]]))
    end

    function range_length(a::Vector{UnitRange{Int}})
        reduce(*, length.(a))
    end

    function subtract3(a::Vector{UnitRange{Int}}, b::Vector{UnitRange{Int}})
        i = intersect.(a,b)
        range_length(i) == 0 && return [a]
        
        filter(x -> range_length(x) > 0, [
            [a[1], a[2], first(a[3]):first(i[3])-1],
            [a[1], a[2], last(i[3])+1:last(a[3])],
            [a[1], first(a[2]):first(i[2])-1, i[3]],
            [a[1], last(i[2])+1:last(a[2]), i[3]],
            [first(a[1]):first(i[1])-1, i[2], i[3]],
            [last(i[1])+1:last(a[1]), i[2], i[3]]
        ])
    end

    function count_boxes(rs::Vector{Tuple{Bool,Vector{UnitRange{Int}}}})
        boxes = Vector{Vector{UnitRange{Int}}}()
        for i=1:lastindex(rs)
            r = rs[i]
            
            boxes_tmp = Vector{Vector{UnitRange{Int}}}()
            for x in boxes
                push!(boxes_tmp, subtract3(x, r[2])...)
            end

            r[1] && push!(boxes_tmp, r[2])
            boxes = boxes_tmp
        end
        range_length.(boxes) |> sum
    end
    
    # Part 1
    println(count_boxes(filter(x -> all(v -> 0 <= first(v) && last(v) <= 101, x[2]), ranges)))
    
    # Part 2
    println(count_boxes(ranges))
end 