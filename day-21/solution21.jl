@time begin
    input = readlines("day-21/input21.txt")
    s_pos = parse.(Int, last.(input))

    # Part 1
    pos = copy(s_pos)
    score = [0,0]
    total_throws = 0
    for n=1:2:1000
        for i=1:2
            pos[i] = mod1(pos[i] + (3 + (n+i-2) * 9 + 3), 10) 
            score[i] += pos[i]
            global total_throws += 3
            score[i] >= 1000 && @goto won
        end
    end
    @label won
    println(minimum(score) * total_throws)

    # Part 2
    roll_counts = Dict{Int,Int}([3=>1, 4=>3, 5=>6,6=>7,7=>6,8=>3,9=>1])
    cache = fill([0,0], 10, 21, 10, 21)
    scores = Set{NTuple{4, Int}}(sort(reshape([(p1, s1, p2, s2) for s1=21:-1:1, s2=21:-1:1,p1=1:10, p2=1:10],(:)); by = sum, rev=true))
    function resolve(p1::Int, s1::Int, p2::Int, s2::Int)
        (p1, s1,p2,s2) ∉ scores && return cache[p1,s1,p2,s2]
        pop!(scores, (p1, s1, p2, s2))
        new_el = [0,0]
        for (r,c) in roll_counts
            np = mod1(p1+r, 10)
            ns = s1+np
            new_el .+= ns >= 22 ? 
                [c, 0] : 
                c * resolve(p2,s2,np,ns)[2:-1:1] 
        end
        cache[p1,s1,p2,s2] = new_el
        return new_el
    end
    
    println(resolve(s_pos[1],1,s_pos[2],1))
end