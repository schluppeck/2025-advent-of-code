%% solution for day 4 of advent of code 2025
%
% ds

%% idea - parse each row into true/false
%
% idea - load file as text

% fname = 'demo.txt';
fname = 'input.txt';

data = textread(fname,'%s','delimiter','\n');
toiletRolls = split(data,'');

% remove leading and trailing columns
toiletRolls = toiletRolls(:, (2:end-1));


%% convert to numbers 0/1

toiletRolls = replace(toiletRolls, '.', '0');
toiletRolls = replace(toiletRolls, '@', '1');

toiletRolls = str2double(toiletRolls);

%% neighbourhood kernel
nh_kernel = [1,1,1; 1 0 1; 1 1 1];

% convolve input with this, but also only check where
% original toiletRoll data == 1

neighbours = conv2(toiletRolls, nh_kernel, "same");

figure()
imagesc(neighbours)
caxis([0 8])
colormap(hot)
axis image
axis ij
axis off

%% both conditions
bothConditions = (toiletRolls == 1) & (neighbours < 4);

% count how many nonzero elements
result = nnz(bothConditions);

%% result
fprintf('\n\nresult is: %d\n', result)
