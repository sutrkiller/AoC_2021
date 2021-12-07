input = open(f->read(f, String), "input2.txt")
commands = [ split(n) |> x -> [x[1] == "forward" ? "h" : "v", parse(Int, x[2]) * (x[1]=="up" ? -1 : 1)] 
    for n in split(input, "\n"; keepempty=false)]

# Part 1
v = foldl((a,c) -> a .+ [c[1]=="h" ? c[2] : 0,c[1]=="v" ? c[2] : 0],commands;init=[0,0])
println(reduce(*, v))

# Part 2
v = foldl((a,c) -> a .+ [c[1]=="v" ? c[2] : 0, c[1]=="h" ? c[2] : 0, c[1]=="h" ? a[1] * c[2] : 0], commands;init=[0,0,0])
println(reduce(*, v[2:end]))