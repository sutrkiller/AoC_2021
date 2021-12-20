@time begin
    input = open(f->read(f, String), "day-17/input17.txt")
    x = (185,221)
    y = (-122,-74)

    solutions = []
    aC = 0
    for n=1:maximum(abs.([x...,2 .* y...]))
        ra = floor(minimum([(185*2/n + n -1)/2, sqrt(185*2)])):ceil(maximum([(221*2/n + n -1)/2, sqrt(221*2)]))
        for a in ra
            xT = (a-n+1 > 0 ? n : a+1) * (a+((a-n+1) > 0 ? a-n+1 : 0))/2
            
            global aC+=1
            for b= floor((2y[1]/n+n)/2):ceil((2y[2]/n +n)/2)
                yT = n * (2b-n +1)/2
                if x[1] <= xT <= x[2] && y[1] <= yT <= y[2]
                   push!(solutions, (a,b)) 
                end
            end
        end
    end

    maxY = maximum(f->f[2], solutions)
    println(Int((maxY + 1)*maxY/2))
    println(length(unique(solutions)))
end