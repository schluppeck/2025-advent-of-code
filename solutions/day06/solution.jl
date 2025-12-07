## solution for day 6 puzzle
#
# ds
#
# moving to julia (BigInt support)

nArgs = length(ARGS)
println("Number of arguments: ", nArgs)
println("Arguments: ", ARGS)

# idea - load file as text
using DelimitedFiles 

if nArgs >= 1
    fname = ARGS[1]
else
    fname = "demo.txt"
    #fname = "input.txt"
end



# more complicated text data / delimited by commas
data = readdlm(fname, '\n' ,String, skipblanks=true);

# reality check ... is there an empty element at end of data
# could be artefact of readdlm
if strip(data[1,end]) == ""
    error(" empty element at end of data ")
end

M = split.(data,"")
N = reduce(hcat,M)   # transpose to get correct orientation

# take the last column as operators
# get rid of empty spaces
# reverse the order of operators to match chunk order
# operators = [o for o in reverse(N[:,end]) if o != " "]  # remove empty spaces

## chunk in a loop
S = BigInt(0) # 
currentChunk = BigInt(0);
currentOp = " ";
for (i,r) in enumerate(eachrow(N))  # all but last column
    global S
    global currentChunk
    global currentOp
    if r[end] == "*" || r[end] == "+"  
        currentOp = r[end]
        println(" found operator: ", currentOp)
        currentChunk = BigInt(0)  # reset current chunk
    end
    # check that we have an op from 1...
    if currentOp == " "
        error(" no operator found for row $(i) ")
    end
    currentString = *(r[1:end-1]...) # concatenate row into string

    println(" row #$(i): '", currentString, "' with op: ", currentOp)
    if strip(currentString) == ""
        @show currentChunk
        S += currentChunk
        println("--- reset chunk!")
        continue
    end
    ## otherwise accrue current chunk!
    currentNum = parse(BigInt, currentString)
    # @show currentNum
    if currentOp == "+"
        currentChunk += currentNum
    elseif currentOp == "*"   
        if currentChunk == BigInt(0)
            # first on the list... make sure to initialize
            currentChunk = parse(BigInt, currentString)
        else  
            if currentNum == 0
                currentChunk *= 1
            else
                currentChunk *= currentNum
            end 
        end
    end
       
    # special case - last row... need to add chunk to total
    if i == size(N,1)
        println(" end of data - adding chunk to total ")
        S += currentChunk
    end
end


println(" final result: $(S)")




# S = BigInt(0)
# toAdd = BigInt(0)
# for (i, c) in enumerate(chunks)
#     global S
#     global operators
#     global toAdd
#     # not quite map/reduce... because we have different operations
#     if operators[i] == "+"
#         typeof(c)
#         toAdd = sum(c)
#         #println(" sum: $(sC)")
#         S += toAdd
#     elseif operators[i] == "*"
#         toAdd = prod(c)
#         #println(" prod: $(pC)") 
#         S += toAdd 
#     else
#         error(" unknown operator: $(operators[i])")
#     end
#     println("#$(lpad(i, 4, '0')), $(lpad(toAdd, 14, ' ')), op: ", operators[i], "\ttotal: $(lpad(S,14,' ')): {T} ", typeof(toAdd))
#     #sleep(0.01)  # to slow down output for readability
# end