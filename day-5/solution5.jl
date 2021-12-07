🌊 = open(💧->read(💧, String), "input5.txt")
🌋 = Dict{Tuple{Int,Int},Int}()

for 💧 in split(🌊, "\n"; keepempty=false)
    🔥 = [parse(Int,🥽.match) for 🥽 in eachmatch(r"\d+", 💧) |> collect]

    # uncomment for Part 1
    # 🔥[1] != 🔥[3] && 🔥[2] != 🔥[4] && continue
    
    📐::Vector{Int} = Int[🔥[3]-🔥[1], 🔥[4]-🔥[2]]
    📏 = maximum(👣 -> abs(👣), 📐)
    📐 = 📏 .\ 📐
    for 📍 in (🔥[1:2] + 👣 .* 📐 for 👣=0:📏)
        🌋[(📍[1],📍[2])] = get(🌋, (📍[1],📍[2]), 0) + 1
    end
end
println(count(👣 -> 👣 > 1, values(🌋)))