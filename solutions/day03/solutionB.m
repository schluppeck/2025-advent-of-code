%% solution for day 3 (#2) of advent of code 2025
%
% ds
%
% similar idea as puzzle 1, but generalise
% from k=2 to k=12

%% idea - parse each row into digits
%
% idea - load file as text

% fname = 'demo.txt';
fname = 'input.txt';

data = textread(fname,'%s','delimiter','\n','whitespace','');
numbers = split(data,'');

% remove leading and trailing columns from conversion
numbers = numbers(:, (2:end-1));

% convert to numbers
numbers = str2double(numbers);

nFloors = size(numbers,1);
nBatteries = size(numbers, 2);

nK = 12; % number of batteries in each pack

fprintf('list has %d floors, %d batteries\n', nFloors, nBatteries);


%% need to maxmimise value for 10^(k-1) first...
%
% that can only be on position 1 to X 
% (to leave enough numbers for the rest of k digits)

function [res  = findMaxJoltage(row, k)
% findMaxJoltage - find max k, k-1,.., 1 values
%
% and return the numbers representing A*10^(k-1) + B*10^(k-2)

% # of batteries
nB = size(row,2);

% for debugging.
digits = zeros(k,1); % store values
digitPos = zeros(k,1); % store their positions

% need to make sure the window where we look
% still allows for k-1 possibles on next step!

startSearch = 1; % first iteration
endSearch = nB - (k-1); % end point for first iteration

for ik = 1:k
    % so on step 1: only look up to nB-(k-1) - need to leave k-1 slots
    %    on step 2:     from previous found index up to nB-(k-2)
    % and so on...

    % special case that might confuse max / indexing
    fprintf('start: %d, end: %d\n',startSearch, endSearch);
    if startSearch == endSearch
        maxN = row(startSearch);
        maxNi = 1;
    else % if there is at least a range like 2:4 or 4:7
        toSearch= row(startSearch:endSearch);
        [maxN, maxNi] = max(toSearch);
        % remember that indeces here are within the search window
        % not the the original 1:nB 
    end
    digits(ik) = maxN;
    digitPos(ik) = maxNi+startSearch; % in terms of actual 1:nB position
    fprintf('maxN: %d, maxNi: %d\n',maxN, maxNi); % local index (search window)

    % on next iteration... need to start at that index
    % but make sure to udpate with the shifting window
    startSearch = maxNi+startSearch; % offset by position where we found max
    endSearch = nB - (k-ik) + 1;     % available remainder / with sufficient space!@
end

% stick the numbers together (in place value)
%... the powers of 10 go 10^11 ie. 10^(k-1) ... to 10^0
% or as we are base 10, str2num will do.
res = sprintf('%d', digits);
res = str2num(res);

end
 
 %% across all floors

floorPower = zeros(nFloors,1);
for iFloor = 1:nFloors
    % collect info for each floor
    floorPower(iFloor) = findMaxJoltage(numbers(iFloor,:), nK);
end


%% result

total = sum(floorPower);
fprintf('%12d\n' ,floorPower')
fprintf('\n\ntotal power is: %d\n', total)
