## solution for day 2 puzzle
#
# ds
#
# moving to julia (BigInt support)

# idea - load file as text
using DelimitedFiles

# fname = 'demo.txt';
fname = "input.txt";

# more complicated text data / delimited by commas
data = readdlm(fname,',',String);

nPairs = length(data)
println("list has $(nPairs) pairs of ids\n");


function validID(num::BigInt)
# validID - check if an ID is valid
#
# - convert to str 
# - has to have even number of digits 
# - and first half same as second half means INVALID

tf = true; # assume valid
str = string(num); # convert to string
nDigits = length(str); # number of digits

if !iseven(nDigits)
    # can't be invalid because can't be split
    tf = true ; # a valid iD
    val = BigInt(0); # does not add to sum
    return tf, val
end

# first and second half
# check if they match.. if yes, then invalid!
tf = !(SubString(str,1,Int(nDigits/2)) == SubString(str,Int(1 + nDigits/2),nDigits))

if !tf
    val = parse(BigInt,str); # convert to #
    println("invalid ID: $(str)")
else
    val = BigInt(0); # does not add to sum
end

return tf, val
end

# go over each pair, make a range and find invalid IDs
sumInValid = [BigInt(0),];

for iPair = 1:nPairs
    global sumInValid
    global res
    println("\n --- pair #$(iPair): $(data[iPair]) ---")
    num1, num2 = split(data[iPair],'-')
    # println("  num1: $(num1), num2: $(num2)")
    if num1 ==  num2 
        println("  skipping empty range")
        continue
    end
    # this step may break without BigInt support
    rangeIDs = parse(BigInt,num1):parse(BigInt,num2)
    # attach invalid IDs to sumInValid
    S = [validID(num)[2] for num in rangeIDs if !validID(num)[1]]
    push!(sumInValid, S...)
end

result = sum(sumInValid)

println("sum of invalid IDs: $(result)")