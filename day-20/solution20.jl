@time begin
    input = open(f->read(f, String), "day-20/input20.txt")
    parts = split(input, "\n\n"; keepempty=false)

    enhance_in = parts[1]
    pixels_in = split(parts[2], "\n";keepempty=false)
    pixels = Set([(y,x) 
        for y = 1:length(pixels_in) 
        for x = 1:length(pixels_in[1]) 
        if pixels_in[y][x] == '#'])
    
    boundaries() = (minimum(f -> f[1], pixels), minimum(f -> f[2], pixels), 
                    maximum(f -> f[1], pixels), maximum(f -> f[2], pixels))
    
    to_int(v::BitVector) = foldr((x,a) -> (a[1]<<1,a[2]+x*a[1]),v;init=(1,0))[2]

    function enhance(y::Int,x::Int;reverse=false)
        adj = [((y2,x2) ∈ pixels) != reverse for y2=y-1:y+1 for x2=x-1:x+1]
        return enhance_in[to_int(adj)+1] == '#'
    end

    function draw() 
        bound = boundaries()
        for y=bound[1]-1:bound[3]+1 
            for x=bound[2]-1:bound[4]+1
                print((y,x) ∈ pixels ? '#' : '.')
            end
            println()
        end
    end
    #draw()

    for i=1:50
        bound = boundaries()
        push_dark = enhance_in[1]=='#' && i % 2 == 1
        enhance_dark = enhance_in[1]=='#' && i % 2 == 0
        results = Set{Tuple{Int,Int}}([])
        for y=bound[1]-1:bound[3]+1 
            for x=bound[2]-1:bound[4]+1
                enhance(y,x; reverse=enhance_dark) == push_dark && continue
                push!(results, (y,x))
            end
        end
        global pixels = results

        #draw()
    end
    println(length(pixels))
end