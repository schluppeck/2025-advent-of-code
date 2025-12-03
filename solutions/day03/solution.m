%% solution for day 3 of advent of code 2025
%
% ds

%% idea - parse each row into digits
%
% idea - load file as text

%fname = 'demo.txt';
fname = 'input.txt';

data = textread(fname,'%s','delimiter','\n','whitespace','');
numbers = split(data,'');

% remove leading and trailing columns
numbers = numbers(:, (2:end-1));

% convert to numbers
numbers = str2double(numbers)

nFloors = size(numbers,1);
nBatteries = size(numbers, 2);

fprintf('list has %d floors, %d batteries\n', nFloors, nBatteries);


%% need to maxmimise value for T(ens) first...
%
% that can only be on position 1 to n-1

function result = findMaxTandO(row)
% findMaxTandO - find max T and O values
%
% and return the numbers representing TO

% # of batteries
nB = size(row,2);
% max T
[maxT, maxTi] = max(row(1:(nB-1)));
% then maximise O(nes)   
% that can only be from its position k+1 to end 
[maxO, maxOi] = max(row((maxTi+1):end));

% stick the numbers together (in place value
result = 10*maxT + maxO;

end

%% across all floors

floorPower = zeros(nFloors,1);
for iFloor = 1:nFloors
    floorPower(iFloor) = findMaxTandO(numbers(iFloor,:))
end


%% result

total = sum(floorPower);
fprintf('%d ' ,floorPower')
fprintf('\n\ntotal power is: %d\n', total)
