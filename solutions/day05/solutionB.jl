## solution for day 5 puzzle (B)
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

idRanges = data[1:breakPoint-1];

# for the second problem... find which ranges need to be extended by overlap

# idea:
# -- start by converting into a list of ranges (start, end)
# -- then sort by start value.
# -- then loop over each range, and see if any of the following ranges start within the current range and extend
#    until there is a break.. then store that range out and proceed


function findMinimalValidRanges(theData::Vector{String})
# findMinimalValidRanges - count loop in loop


# for each pair, check if the other pairs start in the interval?
# if yes, extend the range to include that pair too, if necessary

nPairs = length(theData)
println("number of pairs: $(nPairs)")

# array storing valid ID start, end
out = [];
rangeStartEnd = Array{BigInt}(undef, nPairs, 2);

for iPair = 1:nPairs
    #println("\n --- pair #$(iPair): $(theData[iPair]) ---")
    nums = split(theData[iPair],'-')
    rangeStartEnd[iPair,1] = parse(BigInt,nums[1])
    rangeStartEnd[iPair,2] = parse(BigInt,nums[2])
end

R = sortslices(rangeStartEnd; dims = 1)

# now loop over R and find minimal ranges
currentStart, currentEnd = R[1,:]
for iPair = 1:(nPairs-1)

    nextStart, nextEnd = R[iPair+1,:]



    # check if nextStart is within current range
    # if yes, extend currentEnd if needed
    # set breakBetweenIntervals = false
    # go to next

    # two intervals may start at same start point...
    # but different end points // overlap!
    if nextStart == currentStart 
        #("unexpected - two ranges start at same point")
        if nextEnd > currentEnd
            currentEnd = nextEnd
            breakBetweenIntervals = false
            println("-> extending current range to: ($(currentStart), $(currentEnd))")
        end # otherwise ignore...
    elseif nextStart >= currentStart && nextStart <= (currentEnd+1)
        # extend currentEnd if needed // even if attached
        if nextEnd > currentEnd
            currentEnd = nextEnd
        end 
        breakBetweenIntervals = false
        # got to next and see if that needs to be included too
        println("=> extending current range to: ($(currentStart), $(currentEnd))")
    elseif nextStart == currentEnd + BigInt(1)
        # adjacent ranges - extend currentEnd
        currentStart = currentStart
        currentEnd = nextEnd
        breakBetweenIntervals = false
        println("** extending current range to: ($(currentStart), $(currentEnd))")
        # attached
    else
        # there is a break
        # store current range into output
        push!(out, (currentStart, currentEnd))
        # start new range
        currentStart = nextStart
        currentEnd = nextEnd
        breakBetweenIntervals = true
        println("!! starting new range: ($(currentStart), $(currentEnd))")
        sleep(0.1)
    end
end

# make sure to save out final state.
push!(out, (currentStart, currentEnd))

return out
end

validIdRanges = findMinimalValidRanges(idRanges)

# print the list
[print("$(a)-$(b)\n") for (a,b) in validIdRanges]

# endIndex - startIndex + 1 gives the range
result = [(b-a)+1 for (a,b) in validIdRanges] 


println("\n number of valid IDs found: $(result |> sum)\n\n")


## too high
#.    360497387057543
#.    368992572372162
#[ok] 350513176552950