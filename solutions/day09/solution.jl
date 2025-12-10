## solution for day 9 puzzle
#
# ds
#
# largest rectangles

nArgs = length(ARGS)
println("Number of arguments: ", nArgs)
println("Arguments: ", ARGS)

# idea - load file as text
using DelimitedFiles
using Plots
gr()

if nArgs >= 1
    fname = ARGS[1]
else
    fname = "demo.txt"
    #fname = "input.txt"
end

# more complicated text data / delimited by commas
data = readdlm(fname, ',' ,Int64, skipblanks=true);

@show data 

# idea... make a function that uses two coordinates to calc area

function calculateArea(p1, p2)
    # p1 and p2 are tuples of (x, y)
    x1, y1 = p1
    x2, y2 = p2
    return abs(x2 - x1+1) * abs(y2 - y1+1)
end

A = [calculateArea(o,t) for o in eachrow(data), t in eachrow(data)]

# find max and locatiom
@show maxArea = maximum(A)

@show idx = argmax(A)
@show r, c = idx.I

theme(:juno)
h_ = heatmap(A, axis = nothing, border = :none,
aspect_ratio = 1.0, legend = false, title="Area Heatmap") 

h_|> display
savefig(h_, "heatmap.png")
readline()
exit(87)


