%% solution for day01
%
% ds

%% idea - load file as text
fname = 'demo.txt';
%fname = 'input.txt';

data = textread(fname,'%s','delimiter','\n','whitespace','')

fprintf('list has %d settings\n', numel(data));
%% R rotations are -, L rotations are +
startPoint = 50;

rotations = replace(data, 'R', '+');;
rotations = replace(rotations, 'L', '-');
rotationsNum = str2double(rotations);

%% do the cumulative sum (aggregate rots)
setting = startPoint; 
zeroHits = 0;

for iRot = 1:numel(rotationsNum)
    setting = setting + rotationsNum(iRot)
    % deal with 99..0..1
    setting = mod(setting, 100);
    if setting == 0
        zeroHits = zeroHits + 1;
    end
end

result = zeroHits



