%% AoC solution for puzzle 1 in 2024
%
% just finding our feet 
% 
% denis schluppeck, 2025-11-26 before class

%% load input file (which I copied into txt file)
X = load('demo.txt')

%% use the sort function to achieve first bit

% by default, it sorts down the columns (dimension 1)
% and it also sorts columns independently by default (feature!!)

sortedX = sort(X);

%% now find the distance between them

% by the description is the different across columns.
% but always a positive number (larger - smaller number)

distances = abs(sortedX(:,1) - sortedX(:,2))
% then sum them.

% or matlabic / onelineer (babushka doll):
% the diff() function can take first differences 
% ( [] means it goes with default along dimension 2 (across!)

sum(abs(diff(sort(X),[],2)))


%% we can even make a function (advanced)
distanceFinder = @(A) sum(abs(diff(sort(A),[],2)));


%% apply this function to the proper input 

% 1. step by step
Y = load('input.txt');
output = distanceFinder(Y);

% 2. in place (even shorter)
distanceFinder(load('input.txt'));


disp('the answer is to the main quiz is:')
fprintf('%d\n', output)