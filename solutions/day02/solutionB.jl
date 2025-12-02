## solution for the second day 2 puzzle
#
# ds
#
# moving to julia (BigInt support)

# idea - load file as text
using DelimitedFiles

#fname = "demo.txt";
fname = "input.txt";

# more complicated text data / delimited by commas
data = readdlm(fname,',',String);

data = [d for d in data if d != "" ]; # make sure it's a vector

nPairs = length(data)
println("list has $(nPairs) pairs of ids\n");

function elfValidID(num::BigInt)
# elfValidID - check if an ID is valid
#
# - convert to str 
# - check divisble chunks of equal size for repetition

tf = true; # assume valid
str = string(num); # convert to string
nDigits = length(str); # number of digits


for iChunk = 1:Int(floor(nDigits/2))
    # split into chunks of size iChunk
    if mod(nDigits, iChunk) != 0
        continue # skip non-divisible chunk sizes
    end
    nChunks = Int(nDigits / iChunk)
    # get all chunks / list comprehension!
    chunks = [SubString(str,1 + (i-1)*iChunk, i*iChunk) for i = 1:nChunks]

    # check if unique(chunks) returns exactly 1
    # that means that they are all the same / repeating
    if length(unique(chunks)) == 1
        tf = false; # invalid ID
        println("  invalid ID: $(str), repeating chunk size: $(iChunk)")
        return tf, num # invalid and return the input
    end 
end 

return tf, BigInt(0) # valid and return the input
end

# go over each pair, make a range and find invalid IDs
sumInValid = [BigInt(0),];

for iPair =  1:nPairs
    global sumInValid
    
    println("\n --- pair #$(iPair): $(data[iPair]) ---")
    num1, num2 = split(data[iPair],'-')

    # convert to BigInt
    n1, n2 = parse(BigInt,num1), parse(BigInt,num2)

    # sanity checks
    if n1 ==  n2 
        println("  skipping empty range")
        continue
    end
    if n2 < n1
        error("  invalid range")
    end

    # this step may break without BigInt support
    rangeIDs = n1:n2

    # attach invalid IDs to sumInValid
    # first list comprehension filters by validity
    # S = [elfValidID(num)[2] for num in rangeIDs if !elfValidID(num)[1]]
    S = [elfValidID(num)[2] for num in rangeIDs] # but this calls elfValidID only once
    push!(sumInValid, S...)
end

println("# invalid IDs $(length(sumInValid)-1)") # minus the initial zero

result = sum(sumInValid)

println("sum of invalid IDs: $(result)")

# too big 11323661305 (initial before debugging)
# correct answer for my data: 11323661261
