# Day 06

- [Problem description](https://adventofcode.com/2025/day/6)

Cephalopod maths...

## Tips for first problem

1. Pretty straightforward parsing problem. Read in the input file line by line, and split each line into tokens (numbers and operators). I used `split` after `readdlm` to get a matrix of strings.

2. You can accrue sum with an `if` statement inside a loop. Keep track of the current operation (either `+` or `*`), and when you hit a blank line, add the current chunk to the total sum and reset the chunk. (I thought `mapreduce` might be useful, but it was more complicated than just a loop with an `if` statement.)


## Second problem

- Same idea - but more tricky as the parsing is now harder.

- One trick I used was to transpose the matrix of strings, so that each row corresponds to a column in the input file. This way, I could easily iterate over each line and process the tokens. In a first version I tried to accrue data for each "chunk" in a vector, but that got complicated quickly. So I ended up looping over and keeping track of the current operation and chunk value with global variables.



<!-->
<center>
<img src="animated-day05.gif" width="80%" alt="Day 5 animated gif">
</center>

!-->

Also, I over-wrote the original solution.jl file ... so only code for `Part 2` is available here. And it needs some refactoring and cleaning up!

## Code

<details>
<summary>Julia solution</summary>
<p>
<a href="solution.jl" target="_new">Julia code / solution</a> for the first part of that problem (simpler version of the code ended up as solution for B!).
</p>
<p>
<a href="solution.jl" target="_new">Second part solution</a> of that problem.
</p>

</details>
