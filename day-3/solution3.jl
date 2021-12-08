input = open(f->read(f, String), "input3.txt")
N = vcat([map(x -> parse(Bool, x), n |> collect)' for n in split(input, "\n"; keepempty=false)]...)

toInt(bitarray) = foldl((a,(i, x)) -> a + (x << (i-1)), enumerate(reverse(bitarray)); init=0)

# Part 1
gamma = count(==(1), N; dims=1) .>= size(N)[1] / 2;
epsilon = .!gamma
println(toInt(gamma) * toInt(epsilon))

#Part 2
oxygen = foldl((A, i) -> (size(A)[1] == 1 ? A : A[A[:,i] .== (sum(A[:,i]) >= size(A)[1]/2), :]), 1:size(N)[2]; init= N)
co2 = foldl((A, i) -> (size(A)[1] == 1 ? A : A[A[:,i] .== (sum(A[:,i]) < size(A)[1]/2), :]), 1:size(N)[2]; init= N)
println(toInt(oxygen) * toInt(co2))