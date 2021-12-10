@time begin
    🌊 = open(🐡 -> read(🐡, String), "day-6/input6.txt");

    🐠 = zeros(Int, 9);
    for 🐟 in [parse(Int, 🐡) for 🐡 in split(🌊, ','; keepempty=false)]
        🐠[🐟+1] += 1
    end

    # Change to :80 for Part 1
    for 🕛 in 1:256
        🐟 = ((🕛 - 1) % 9) + 1
        🐡 = ((🐟 + 6) % 9) + 1
        🐠[🐡] += 🐠[🐟]
    end
    println(sum(🐠))
end