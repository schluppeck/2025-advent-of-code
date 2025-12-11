## solution for day 11 puzzle
#
# ds
#
# --- Day 11: Reactor ---
# path finding -- every path from you to out

nArgs = length(ARGS)
println("Number of arguments: ", nArgs)
println("Arguments: ", ARGS)

# idea - load file as text
using DelimitedFiles
using Plots
using Graphs
# using ProgressBars
if nArgs >= 1
	fname = ARGS[1]
else
	fname = "demo-2.txt"
	#fname = "input.txt"
end

function parse_line(line)
	# process line
	src, targets = split(line, ": ")
	targets = String.(split(targets, " "))
	return (src, targets)
end

function get_all_nodes(text_nodes)
    nodes = String[]
    for (src, targets) in text_nodes
        push!(nodes, src)
        append!(nodes, targets)
    end
    return unique(nodes)
end

function build_graph(text_nodes)
    all_nodes = get_all_nodes(text_nodes)
    node_indices = Dict{String, Int}()
    for (i, node) in enumerate(all_nodes)
        node_indices[node] = i
    end
    g = SimpleDiGraph(length(all_nodes))
    for (src, targets) in text_nodes
        src_idx = node_indices[src]
        for tgt in targets
            tgt_idx = node_indices[tgt]
            add_edge!(g, src_idx, tgt_idx)
        end
    end
    return g, node_indices
end


text_nodes = []
open(fname) do f
	for p in (parse_line(x) for x in eachline(f))
		# println("src: ", p[1], ", targets: ", p[2])
        push!(text_nodes, p)
    end
end

println("All nodes (max. first 100...): ", get_all_nodes(text_nodes)[1:min(100, end)])

# make the graph
G, node_indices = build_graph(text_nodes)


sidx = node_indices["svr"]
eidx = node_indices["out"]

visitidx = [node_indices[k] for k in ["fft","dac"]]


# ChatGPT suggestion for using DFS
# can you suggest a julia function that will find 
# paths from one given node to another in a directed 
# graph, but with the condition that two other nodes 
# are also visited on those paths. use graphs.jl and 
# pure julia functions for this and estimate the 
# efficiency of the solution


"""
    paths_via_nodes(g, src, dst, required_nodes)

Return all simple paths from `src` to `dst` in directed graph `g` that visit
all nodes in `required_nodes` at least once.
"""
function paths_via_nodes(g::DiGraph, src, dst, required_nodes::Vector)
    required_set = Set(required_nodes)
    results = Vector{Vector{Int}}()

    function dfs(u, visited, path, required_left)
        # stop if revisiting a node (simple paths only)
        if u in visited
            return
        end

        # update visited, path
        push!(path, u)
        push!(visited, u)

        # update unvisited required nodes
        if u in required_left
            required_left = setdiff(required_left, [u])
        end

        # check termination condition
        if u == dst && isempty(required_left)
            push!(results, copy(path))
        else
            # explore neighbors
            for v in outneighbors(g, u)
                dfs(v, visited, path, required_left)
            end
        end

        # backtrack
        pop!(path)
        pop!(visited)
    end

    dfs(src, Set{Int}(), Int[], required_set)
    return results
end

#A = paths_via_nodes(G, sidx, eidx, visitidx)
#println("All paths from 'svr' to 'out' via 'fft' and 'dac': ", size(A,1))





#exit(0)




# Map node → color
nodefill = [node in sidx ? "yellow" :
            node in eidx ? "red" :
            node in visitidx ? "orange" :
                            "lightgreen"
            for node in 1:nv(G)]

# Map node → color
nodesize = [node in sidx ? 30 :
            node in eidx ? 30 :
            node in visitidx ? 30 : 1
            for node in 1:nv(G)]



using GraphPlot, Compose
draw(SVG("./visit.svg", 32cm, 32cm),
        gplot(G, 
        #linetype="curve", 
        #layout = circular_layout,
        nodefillc=nodefill,
        nodesize=nodesize,
        arrowlengthfrac=0.0,
        arrowangleoffset=π/12,
        edgestrokec="gray",
        edgelinewidth=0.1,
        #background_color="black"
        ))


