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
    rolls = [(i,j,k) for i=1:3 for j=1:3 for k=1:3]
    roll_counts = Dict([(i => count(x -> sum(x) == i, rolls)) for i=3:9])
    function rec(pos, sc,  p)
        wins = [0,0]
        for r=3:9
            npos = copy(pos)
            npos[p] = mod1(pos[p] + r, 10)
            nsc = copy(sc)
            nsc[p] += npos[p]

            if nsc[p] >= 21
                wins[p] += roll_counts[r]
            else
                wins += roll_counts[r] * rec(npos, nsc, mod1(p+1,2))
            end
        end
        wins
    end

    wins = rec(s_pos, [0,0], 1)
    println(maximum(wins))
end