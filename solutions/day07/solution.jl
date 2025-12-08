## solution for day 7 puzzle
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
# data = readdlm(fname, '\n' ,String, skipblanks=true);

# this seems cleaner:
# https://dev.to/rpalo/read-a-delimited-file-into-a-2d-array-in-julia-2236
lines = map(collect, readlines(fname))
data = permutedims(hcat(lines...))

# but strings not chars, I think??
# or not for now... must remember to do char comparisions


# reality check ... is there an empty element at end of data
# could be artefact of readdlm
if data[1,end] == ' '
    error(" empty element at end of data ")
end

# @show data

sourceLocation = findall(x -> x == 'S', data)

# reality check 
if length(sourceLocation) != 1
    error(" expected exactly one source location ")
end

(srow, scol) = sourceLocation[1].I
if srow != 1
    error(" expected source to be in first row ")
end

function simulateBeam(M)
        
    # beam travel simulation here ...
    N = similar(M) # the one that updates...
    nRows, nCols = size(M)
    println(" data size: $(nRows) rows, $(nCols) cols ")
    
    sourceChar = 'S'
    beamSplitter = '^'
    beam = '|'
    
    # row 1 contains 1 source only, so advance to row 2
    # unpack source location
    scol = M[1,:] .== sourceChar
    println(" source at row $(srow), col $(scol) ")

    N[1,:]  = M[1,:]
    N[2,:]  = M[2,:] # but replace with beam
    N[2,scol] .= beam
    # from the 3rd row onwards, simulate beam travel
    # by looking above and placing beams...
    nHits = 0 
    nTravels = 0
    for iRow in 3:nRows
        N[iRow, :] = M[iRow, :]
        # look above
        previousBeamCols= findall(x -> x == beam, N[iRow-1, :])
        currentSplitterCols = findall(x -> x == beamSplitter, M[iRow, :])
        currentSpaceCols = findall(x -> x == '.', M[iRow, :])
        travels = intersect(previousBeamCols, currentSpaceCols) 
        hits = intersect(previousBeamCols, currentSplitterCols)
        #@show previousBeamCols
        #@show currentSplitterCols
        @show hits
        @show travels
        # and update
        # - travels straight down
        for col in travels
            nTravels += 1
            N[iRow, col] = beam
        end
        # - hits splitter, split beam
        # place beams to left and right, but don't
        # replaces splitters!
        for col in hits
            nHits += 1
            if (col > 1) && (N[iRow, col - 1] == '.') # left split
                N[iRow, col - 1] = beam
            end
            if (col < nCols) && (N[iRow, col + 1] == '.') # right split
                N[iRow, col + 1] = beam
            end
        end
    end
    return N, nHits, nTravels
end

N, nHits, nTravels = simulateBeam(data)
    
niceN = join([join(row) for row in eachrow(N)], "\n")
print(niceN)
println("\n\nnumber of splitters hit: $(nHits) ")
println("number of beam travels: $(nTravels) ")

#
open(*("s-", fname),"a") do io
   println(io,niceN)
end