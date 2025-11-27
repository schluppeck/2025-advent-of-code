# Example - Day 01 (2024)

The [Problem description](https://adventofcode.com/2024/day/1) explains the task.

You need to think about `sort`ing lists, taking `diff`erences, and `sum`ming.

Write down a plan before coding - like a kind of essay plans - what are the steps you need to take to solve the problem? You can use `%` to write comments in matlab code

```matlab
%% this is a comment (for humans, ignored by matlab)
%  two % signs make it a "snippet" that can be run 
%  separately in matlab.

%% 1. somehow read the data in

%% 2. sort the data (columns?) 
```

<details>
<summary>Matlab solution (no peeking!)</summary>
<p>
<a href="solution.m" target="_new">Matlab code / solution</a> for the first part of that problem.

```matlab
distanceFinder = @(A) sum(abs(diff(sort(A),[],2)));
```
</p>
</details>
