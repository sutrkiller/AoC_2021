using Statistics

@time begin
    🌊 = open(💧-> read(💧, String), "day-7/input7.txt");
    🦀 = [parse(Int, 🤿) for 🤿 in split(🌊, ','; keepempty=false)]

    # Part 1
    println(🦀 .- median(🦀) .|> abs |> sum |> Int)

    #Part 2
    ⚓ = floor(mean(🦀))
    println((abs.(🦀 .- ⚓) .+1) .* abs.(🦀 .- ⚓) ./2 |> sum |> Int)
end