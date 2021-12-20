using Match

function fromhex(s::String)
    newS = ""
    for i in rstrip(s)
        newS *= lpad(string(parse(Int, i; base=16), base=2), 4, "0")  
    end
    newS
end

struct Packet
    bitlength::Int
    version::Int
    typeid::Int
    value::Int
    subpackets::Vector{Packet}
end

@time begin
    input = open(f->read(f, String), "day-16/input16.txt")
    bin = fromhex(input)

    versions = 0;
    toint(s::String) = parse(Int, s; base=2)    
    function parsepacket(s::String; trim_trz = true)
        l = 0
        ver = toint(s[1:3])
        typeid = toint(s[4:6])
        s = s[7:end]
        l += 6
        global versions += ver

        if typeid == 4 
            val = ""
            while true
                val *= s[2:5]
                islast = s[1] == '0'
                l+=5
                s = s[6:end]
                islast && break;
            end

            return Packet(l,ver,typeid,toint(val),[])
        else
            lengthtypeid = toint(s[1:1])
            s = s[2:end]
            l+=1
            subpackets = [] 
            if (lengthtypeid == 0)
                totallength = toint(s[1:15])
                s = s[16:end]
                l += 15
                inners = s[1:totallength]
                s = s[totallength+1:end]
                l+=totallength            
                while length(inners) > 10
                    p = parsepacket(inners;trim_trz=false)
                    push!(subpackets, p)
                    inners = inners[p.bitlength+1:end]
                end
            else
                nsubpackets = toint(s[1:11])
                s = s[12:end]
                l+=11
                for i in 1:nsubpackets 
                    p = parsepacket(s;trim_trz = false)
                    push!(subpackets, p)
                    s = s[p.bitlength+1:end]
                    l+=p.bitlength
                end
            end

            ivals = map(x -> x.value, subpackets)
            val = if typeid == 0
                sum(ivals)
            elseif typeid == 1
                reduce(*,ivals)
            elseif typeid == 2
                minimum(ivals)
            elseif typeid == 3
                maximum(ivals)
            elseif typeid == 5
                ivals[1] > ivals[2] ? 1 : 0
            elseif typeid == 6
                ivals[1] < ivals[2] ? 1 : 0
            elseif typeid == 7
                ivals[1] == ivals[2] ? 1 : 0
            else
                0
            end
            
            return Packet(l,ver,typeid,val,subpackets)
        end
    end

    packets = []

    #println(length(bin),": ",bin)
    root = parsepacket(bin)

    println(versions)
    println(root.value)
end