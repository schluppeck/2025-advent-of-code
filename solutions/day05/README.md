# Day 05

- [Problem description](https://adventofcode.com/2025/day/5)

Another problem involving large ranges of IDs. This time the IDs can be very large - up to X digits long! So you have to be careful about how you represent them in your code. My solution here is to just head straight to `julia` which has built-in support for big integers.

## Tips for first problem

0. The input file contains a list of ranges of IDs, e.g. `11-30,12344-14999,...` - but then it's followed by actual IDs that you have to check against those ranges. So parsing in two parts ... or my read: read into a vector of strings, then find the first empty line which signals the break between the two parts.

1. You have to parse the file. You can do this with `textread()` in matlab by specifying the delimiter as `,` - and you will end up with a piece of text that contains the ranges of IDs. E.g. `11-30` or `12344-14999` or smilar

2. Splitting on the `-` will give you the start and end of the range for each pair. This can be done with `regexp(data,'-','split')` or a similar call

3. Then you can loop over each pair, and generate the list of IDs in that range with `startID:endID` - but be careful here - `BigInteger` support is needed for very large numbers.

- then you can concatenate all those ranges into a big `set` of valid IDs and use `intersect()` to find which of the input IDs are valid. Set operations tend to be very quick, so unless there are memory problems, this should work ok!

- *AHA* - the ranges are too big to allocate... so actually, you need to work with the ranges directly. For each input ID, check if it falls within any of the ranges. This can be done with a loop over the ranges, or more efficiently by sorting the ranges and using a binary search approach.

## Second problem

Same idea - working with sets for each ID is going to be too big. So you need to merge the ranges first, then count the total number of IDs covered by the merged ranges. This means working with the `start` and `end` points of each range.

- I sorted the ranges by their start points. Then I looped through them, keeping track of the current merged range. If the next range overlaps or is adjacent to the current merged range, I extend the current range. If not, I save the current range and start a new one. (The tricky bits were the edge cases, when ranges started at the same point, or were adjacent.)

- The result is a list of intervals... and then to calculate # of valid IDs in each range, calculate `end-start+1`, and then just sum up the lengths of those intervals.

- a nice `julian` pattern is to use list comprehensions which are much more compact than loops for simple operations like this.
 
```julia
# print the list / this will print A-B for each range
[print("$(a)-$(b)\n") for (a,b) in validIdRanges]

# endIndex - startIndex + 1 gives the range
# this will calculate the difference for each row
# and store in a vector
result = [(b-a)+1 for (a,b) in validIdRanges] 

result |> println # check out infix operator!!
```


<center>
<img src="animated-day05.gif" width="80%" alt="Day 5 animated gif">
</center>


## Code

<details>
<summary>Julia solution</summary>
<p>
<a href="solution.jl" target="_new">Julia code / solution</a> for the first part of that problem.
</p>
<p>
<a href="solutionB.jl" target="_new">Second part solution</a> of that problem.
</p>

</details>
