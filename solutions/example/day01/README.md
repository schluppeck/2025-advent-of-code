# Example - Day 01 (2024)

- [Problem description](https://adventofcode.com/2024/day/1)

Sorting lists, taking differences, and summing.

[Matlab code / solution](solution.m) for the first part of that problem.

```matlab
distanceFinder = @(A) sum(abs(diff(sort(A),[],2)));
```