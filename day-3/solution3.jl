@time begin 
    input = open(f->read(f, String), "day-3/input3.txt")
    ps(x::Array{Char}) = parse.(Int, x)'
    N = vcat([ps(n) for n in split(input, "\n"; keepempty=false) .|> collect ]...)
    
    toInt(bitarray) = foldl((a,(i, x)) -> a + (x << (i-1)), enumerate(reverse(bitarray)); init=0)

    # Part 1
    gamma = count(==(1), N; dims=1) .>= size(N)[1] / 2;
    epsilon = .!gamma
    println(toInt(gamma) * toInt(epsilon))

    #Part 2
    select_max(A::Matrix{Int}, i::Int) = size(A)[1] == 1 ? A : A[A[:,i] .== (sum(A[:,i]) >= size(A)[1]/2), :]
    select_min(A::Matrix{Int}, i::Int) = size(A)[1] == 1 ? A : A[A[:,i] .== (sum(A[:,i]) < size(A)[1]/2), :]
    oxygen = foldl(select_max, 1:size(N)[2]; init = N)
    co2 = foldl(select_min, 1:size(N)[2]; init = N)
    println(toInt(oxygen) * toInt(co2))
end