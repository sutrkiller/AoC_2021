@time begin
    input = open(f->read(f, String), "day-19/input19.txt")
    parts = split(input, "\n\n"; keepempty=false)

    scanners = parts .|> (x -> split(x,"\n";keepempty=false)[2:end] .|> y -> parse.(Int, split(y,',')))

    TM = [[1 0 0; 0 0 -1; 0 1 0],[0 0 1; 0 1 0; -1 0 0], [0 -1 0; 1 0 0; 0 0 1]]
    transform(v, x,y,z) = TM[1]^x * TM[2]^y * TM[3]^z * v
    all_rotations = [[x,y,z] for x=1:4 for y=1:4 for z=1:4]

    processed = [(1, [0,0,0], [0,0,0], length(scanners[1]))]
    unique_beacons = [scanners[1]...]
    remaining = collect(2:lastindex(scanners))
    rounds = 1
    while length(remaining) > 0
        scanner_index = popfirst!(remaining)
        scanner = scanners[scanner_index]
        for beacon in scanner[1:end]
            tested = []
            for rotation in all_rotations
                transformed_s = transform(beacon, rotation...)
                transformed_s ∈ tested && continue
                push!(tested, transformed_s)

                search_space = sum(x -> x[4],processed[rounds:end])
                for existing in unique_beacons[end-search_space+1:end]
                    move = existing - transformed_s
                    transformed_a = (move,) .+ (transform.(scanner, rotation...))
                    duplicates = intersect(unique_beacons, transformed_a)

                    if length(duplicates) >= 12
                        new_beacons = setdiff(transformed_a, unique_beacons)
                        push!(unique_beacons, new_beacons...)
                        push!(processed,(scanner_index, move, rotation, length(new_beacons)))
                        #println("$scanner_index: $move, $rotation - $(length(unique_beacons))")
                        @goto next
                    end
                end
            end
        end
        
        #println("$scanner_index: nothing")
        push!(remaining, scanner_index)
        @label next
        length(remaining)>0 && scanner_index >= maximum(remaining) && (global rounds += 1)
    end
    # Part 1
    println(length(unique_beacons))

    # Part 2
    max_distance = 0
    for x=1:lastindex(processed)
        for y=x+1:lastindex(processed)
            dis = sum(abs.(processed[x][2] - processed[y][2]))
            dis > max_distance && (global max_distance = dis)
        end
    end
    println(max_distance)
end