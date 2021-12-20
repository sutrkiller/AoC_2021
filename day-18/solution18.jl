@time begin
    input = readlines("day-18/input18.txt")

    function add(a::String, b::String) 
        "[$a,$b]"
    end

    function explode(a::String)
        depth = 0
        explodeIndex = -1
        for (i,x) in enumerate(a)
            x == '[' && (depth+=1)
            x == ']' && (depth-=1)
            depth >= 5 && match(r"^\[\d+,\d+\]", a[i:end]) !== nothing && (explodeIndex=i;break) 
        end
        explodeIndex == -1 && return nothing
        nte = match(r"(\d+),(\d+)", a[explodeIndex:end])
        ntep = parse.(Int, nte.captures)
        lte = match(r"^(.*?)(\d+)(\D*)$", a[1:explodeIndex-1])
        rte = match(r"^(.*?)(\d+)(.*)$", a[explodeIndex+2+length(nte.match):end])
        if (!isnothing(lte))
            lte[1] * string(parse(Int,lte[2])+ntep[1]) * lte[3]    
        else
            a[1:explodeIndex-1]
        end *
            string(0) *
        if(!isnothing(rte))    
            rte[1] * string(parse(Int,rte[2]) + ntep[2]) * rte[3]
        else
            a[explodeIndex + length(nte.match)+2:end]
        end
    end

    function nsplit(a::String)
        nts = match(r"^(.*?)(\d{2,})(.*)$", a)
        isnothing(nts) && return nothing 
        ntsp = parse(Int,nts[2])
        return nts[1] * "[$(Int(floor(ntsp/2))),$(Int(ceil(ntsp/2)))]" * nts[3]
    end

    function reduce_number(a::String)
        while true
            exploded = explode(a)
            !isnothing(exploded) && (a = exploded;continue)
            splitted = nsplit(a)
            !isnothing(splitted) && (a = splitted;continue)
            isnothing(exploded) && isnothing(splitted) && return a
        end
    end
    function get_magnitude(a::String)
        !isnothing(match(r"^\d+$", a)) && return parse(Int, a)
        coms = findall(',', a)
        half = findfirst(i -> count('[',a[2:i-1]) == count(']',a[2:i-1]), coms)
        return 3 * get_magnitude(a[2:coms[half]-1]) + 2 * get_magnitude(a[coms[half]+1:end-1])
    end
    
    # Part 1
    result = foldl((a,n) -> reduce_number(add(a,n)), input)
    println(get_magnitude(result))

    # Part 2
    max_magnitude = 0
    for j=1:lastindex(input)
        for k=j+1:lastindex(input) 
            newm = get_magnitude(reduce_number(add(input[j], input[k])))
            newm > max_magnitude && (global max_magnitude = newm)
            newm = get_magnitude(reduce_number(add(input[k], input[j])))
            newm > max_magnitude && (global max_magnitude = newm)
        end
    end
    println(max_magnitude)
end