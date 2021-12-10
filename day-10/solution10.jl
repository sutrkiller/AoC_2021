@time begin
    input = open(f->read(f, String), "day-10/input10.txt")
    lines = split(input, "\n"; keepempty=false) .|> collect

    dict = Dict('(' => ')', '[' => ']', '{' => '}', '<' => '>')
    scoring_inv = Dict(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)
    scoring_inc = Dict(')' => 1, ']' => 2, '}' => 3, '>' => 4)

    score_inv = 0;
    scores_inc = [];
    @time for line in lines
        queue = []
        # Part 1
        for c in line
            c ∈ keys(dict) && (push!(queue, c); continue)
            dict[pop!(queue)] ≠ c && (global score_inv += scoring_inv[c]; @goto end_loop)
        end

        # Part 2
        if length(queue) > 0
            scorep = 0
            for a in reverse(queue)
                scorep *= 5 
                scorep += scoring_inc[dict[a]]
            end
            push!(scores_inc, scorep)
        end

        @label end_loop
    end

    println(score_inv)
    println(sort(scores_inc)[Int(end / 2 + .5)])
end