@time begin
    input = open(f->read(f, String), "day-13/input13.txt")
    parts = split(input, "\n\n"; keepempty=false)
    
    dots = (split(parts[1], "\n"; keepempty=false) .|> x-> reverse(parse.(Int, split(x, ","))))
    
    function write_output(io)
        maxY = 0
        maxX = 0
        for i in dots
            i[1] > maxY && (maxY = i[1])
            i[2] > maxX && (maxX = i[2]) 
        end
        m = fill(".", maxY+1, maxX+1)
        for i in dots 
            m[i[1]+1,i[2]+1] = "#"
        end
        for i = 1:size(m)[1]
            println(io,m[i,:])
        end
    end

    for foldLine in split(parts[2], "\n";keepempty=false)
        m = match(r"([x,y])=(\d+)", foldLine)
        l = parse(Int, m[2])
        inx = m[1] == "x" ? 2 : 1
        
        filter!(x -> x[inx] != l, dots)
        for i in dots
            i[inx] < l && continue; 
            i[inx] = l - i[inx] + l
        end
        unique!(dots)
    end

    open(write_output, "day-13/output.txt", "w")
end