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

%% make a function that removes toiletRolls 
function [out, n_removed] = removeRolls(in, nh_kernel)
% removeRolls - a function that removes rolls
%
%
% neighbourhood kernel
if nargin <2
    nh_kernel = [1,1,1; 1 0 1; 1 1 1];
end

% convolve input with this, but also only check where
% original toiletRoll data == 1

neighbours = conv2(in, nh_kernel, "same");
bothConditions = (in == 1) & (neighbours < 4);

% prepare output
n_removed = nnz(bothConditions);

out = in; % start with original
out(bothConditions) = 0; % remove the ones that are removable
end

%% now iterate until n_removed == 0
all_removed = [];
all_stages = [];
in = toiletRolls; % first time
while true
    
    [out, n_removed] = removeRolls(in);

    if n_removed == 0
        break
    end
    
    % otherwise append to all_removed
    all_removed = [all_removed; n_removed];
    all_stages = cat(3,all_stages, out);
    % and prepare for next loop
        in = out;
end

all_removed
result = sum(all_removed)


%% result

fprintf('\n\nresult is: %d\n', result)

%% make a nice image?