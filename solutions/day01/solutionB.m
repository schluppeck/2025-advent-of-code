%% solution for day01 - B
%
% ds

%% idea - load file as text
% fname = 'demo.txt';
fname = 'input.txt';

data = textread(fname,'%s','delimiter','\n','whitespace','');

fprintf('list has %d settings\n', numel(data));
%% R rotations are -, L rotations are +
startPoint = 50;

rotations = replace(data, 'R', '+');;
rotations = replace(rotations, 'L', '-');
rotationsNum = str2double(rotations);

%% idea for part 2 is:
%
% keep track of all the dial position visited, so
% R50 = +50 becomes a segment 0 + 1:50... to careful to keep MOD!
% so +5000 would be 0 + mod(1:5000, 100)


%% keep track of dialPositions (mod 100)

setting = startPoint;
dialPositions = [startPoint];

% go through all the rotations and append the intermediate positions
% we are growing a vector here, so not good form, but < 700,000 entries
% so manageable

for iRot = 1:numel(rotationsNum)
    currentRot = rotationsNum(iRot);
    if currentRot >= 0
        dialPositions = cat(2,dialPositions, ...
            mod(dialPositions(end)+[1:currentRot], 100));
    else % currentRot is negative
        dialPositions = cat(2,dialPositions, ...
            mod(dialPositions(end) + [-1:-1:currentRot],100));
    end
end
%% to give an intution of what that looks like

f_ = figure()
plot(dialPositions(1:800), 'r.')
% only run dark_mode if function exists
if exist('plot_darkmode') == 2
    plot_darkmode()
end
ylabel('Dial position')
xlabel('dial step increment')

hold('on')
h_ = hline([0 99], 'y-')
fontsize(14,'points')
axis([0 inf, -5 104])
hold('off')
title('dial positions over "clicks" [first 800 values]')


%% find number of zeros in there:

numel(find(dialPositions == 0))


%% save image out
f_.InvertHardcopy = 'off';
print(f_, 'plot-positions.png', '-dpng', '-r200')
