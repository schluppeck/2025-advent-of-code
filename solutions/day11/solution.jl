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

if nArgs >= 1
	fname = ARGS[1]
else
	fname = "demo.txt"
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

G, node_indices = build_graph(text_nodes)


sidx = node_indices["you"]
eidx = node_indices["out"]

# shortest paths
#D = dijkstra_shortest_paths(G, sidx)

# all simple paths
A = all_simple_paths(G, sidx, eidx)
# A is an iterator of paths

println("All paths from 'you' to 'out':", size(collect(A),1))

exit(66)

using GraphPlot, Compose
draw(SVG("./test.svg", 32cm, 32cm),
        gplot(G, 
        #linetype="curve", 
        #layout = circular_layout,
        arrowlengthfrac=0.05,
        arrowangleoffset=π/12,
        edgestrokec="gray",
        nodefillc="green",
        #background_color="black"
        ))


