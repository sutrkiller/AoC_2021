@time begin 
    input = open(f->read(f, String), "day-2/input2.txt")
    parseCommand(lvec) = (lvec[1] == "forward" ? "h" : "v", parse(Int, lvec[2]) * (lvec[1]=="up" ? -1 : 1))
    commands = split(input, "\n"; keepempty=false) .|> split .|> parseCommand

    # Part 1
    v = foldl((a,c) -> a .+ [c[1]=="h" ? c[2] : 0, c[1]=="v" ? c[2] : 0], commands; init=[0,0])
    println(reduce(*, v))

    # Part 2
    v = foldl((a,c) -> a .+ [c[1]=="v" ? c[2] : 0, c[1]=="h" ? c[2] : 0, c[1]=="h" ? a[1] * c[2] : 0], commands; init=[0,0,0])
    println(reduce(*, v[2:end]))
end