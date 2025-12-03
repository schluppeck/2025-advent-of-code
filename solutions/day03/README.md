# Day 03

- [Problem description](https://adventofcode.com/2025/day/3)


## Tips

- find the location of the largest number in a position that still leaves enough space to the right to fit the required number of digits (only 1 more in this case)

- `max` function returns both the maximum value and its index position, which is useful

- adjust your search range according to what the first `max` search returned

## Second problem

- a generalisation... now the search window size is variable because the values are `k=12` digits long embedded within a string of length `n=100` digits

- the tricky bit is adjusting the `start` and `end` points of the search window as each iteration goes alon.

- beware of off-by-one errors (I made a few of those... ;)


<center>
<img src="animated.gif" width="80%" alt="Day 3 animated gif">
<br>
<caption>Animated gif showing the search for the largest 12-digit number in s 100-digit strings.</caption>
</center>


## Code

<details>
<summary>Matlab solution</summary>
<p>
<a href="solution.m" target="_new">Matlab code / solution</a> for the first part of that problem.
</p>
<p>
<a href="solutionB.m" target="_new">Second part solution</a> of that problem.
</p>

</details>
