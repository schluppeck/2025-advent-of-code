function count_paths(filename)
    # full disclosure: this function was 98% written by chatGPT
    # I just added in the functionality to road in the
    # generated path file from my `solution.jl` code.
    #
    # Read diagram as array of strings (each line is a row)
    diagram = readlines(filename)
    R = length(diagram)
    C = maximum(length.(diagram))

    # Pad each row to same width with '.' to simplify indexing
    diagram = [r * repeat(".", C - length(r)) for r in diagram]

    # DP array: dp[row][col] = number of ways to reach (row,col)
    dp = [zeros(Int, C) for _ in 1:R]

    # Find starting point 'S' in the first row
    start_col = findfirst(==('S'), diagram[1])
    dp[1][start_col] = 1

    # Iterate rows top to bottom
    for r in 1:R-1
        for c in 1:C
            ways = dp[r][c]
            if ways == 0
                continue
            end

            cell = diagram[r][c]

            if cell == 'S' || cell == '|'
                # move straight down
                if diagram[r+1][c] != '.'
                    dp[r+1][c] += ways
                end

            elseif cell == '^'
                # split: down-left
                if c > 1 && diagram[r+1][c-1] != '.'
                    dp[r+1][c-1] += ways
                end
                # split: down-right
                if c < C && diagram[r+1][c+1] != '.'
                    dp[r+1][c+1] += ways
                end
            end
        end
    end

    # Sum all paths reaching the last row
    return sum(dp[R])
end


nArgs = length(ARGS)
println("Number of arguments: ", nArgs)
println("Arguments: ", ARGS)

if nArgs >= 1
    fname = ARGS[1]
else
    fname = "demo.txt"
    #fname = "input.txt"
end

# Example usage:
println(count_paths(fname))
