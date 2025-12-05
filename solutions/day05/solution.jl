## solution for day 5 puzzle
#
# ds
#
# moving to julia (BigInt support)

# idea - load file as text
using DelimitedFiles

#fname = "demo.txt";
fname = "input.txt";

# more complicated text data / delimited by commas
data = readdlm(fname,'\n',String,
                skipblanks=false);

nEntries = length(data)
println("list has $(nEntries)\n");

# where is the transition between pairs and IDs
breakPoint = findfirst(x->x=="",vec(data))

validIdRanges = data[1:breakPoint-1];
actualIDs = data[breakPoint+1:end];


function countValidIdsInRanges(data::Vector{String}, ids::Vector{String})
# countValidIdsInRanges - count loop in loop

nPairs = length(data)
nIds = length(ids)

allIds = parse.(BigInt,ids)
validIds = [];
for iPair = 1:nPairs

    println("\n --- pair #$(iPair): $(data[iPair]) ---")
    nums= split(data[iPair],'-')
    
    # still vec!
    num1 = parse(BigInt,nums[1])
    num2 = parse(BigInt,nums[2])

    println("  num1: $(num1), num2: $(num2)")
    if num1 ==  num2 
        println("  skipping empty range")
        continue
    end
    
    # now loop over all ids and check if they are in range
    for id in allIds
        if id >= num1 && id <= num2
            push!(validIds, id)
        end
    end
 
end
s = Set(validIds)
return length(s), s
end

A, B = countValidIdsInRanges(validIdRanges, actualIDs)

B |> println
println("\n number of valid IDs found: $(A)")
