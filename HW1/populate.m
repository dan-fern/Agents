%% Populate map, generate all possible actions
function [ grid ] = populate(nrows, ncols, apos, tpos)

grid.map = -1 + zeros(nrows,ncols);
grid.action = 4 + zeros(nrows,ncols);
grid.actions = cell(nrows,ncols);
[grid.actions{:}] = deal([0 0 0 0]);
grid.Q = cell(nrows,ncols);
[grid.Q{:}] = deal([0 0 0 0]);
grid.map(apos) = -100;
grid.map(tpos) = 100;
grid.corners = [1 nrows (nrows*ncols - nrows + 1) (nrows * ncols)];
grid.walls = [];
for j = 1:(nrows - 2)
    grid.walls = horzcat(grid.walls, (nrows - j), (nrows * ncols - j));
end

for k = 2:(ncols - 1)
    grid.walls = horzcat(grid.walls, (ncols) / 2 * k, ncols / 2 * k - 4);
end
grid.walls = sort(grid.walls);

grid.action(grid.walls) = 3;
grid.action(grid.corners) = 2;

for i = 1:(nrows * ncols)
    if grid.action(i) == 2
        if i == 1 
            grid.actions{i}(1) = i + 1;
            grid.actions{i}(2) = i + 5;
        elseif i == 5
            grid.actions{i}(1) = i - 1;
            grid.actions{i}(2) = i + 5;
        elseif i == 46 
            grid.actions{i}(1) = i + 1;
            grid.actions{i}(2) = i - 5;
        else
            grid.actions{i}(1) = i - 1;
            grid.actions{i}(2) = i - 5;
        end
        grid.actions{i}(3) = NaN;
        grid.actions{i}(4) = NaN;
        grid.Q{i}(3) = NaN;
        grid.Q{i}(4) = NaN;
    elseif grid.action(i) == 3
        if i == 2 || i == 3 || i == 4
            grid.actions{i}(1) = i - 1;
            grid.actions{i}(2) = i + 1;
            grid.actions{i}(3) = i + 5;
        elseif i==10 || i==15 || i==20 || i==25 || i==30 || i==35 || i==40 || i==45
            grid.actions{i}(1) = i - 1;
            grid.actions{i}(2) = i - 5;
            grid.actions{i}(3) = i + 5;
        elseif i == 47 || i == 48 || i == 49
            grid.actions{i}(1) = i - 1;
            grid.actions{i}(2) = i + 1;
            grid.actions{i}(3) = i - 5;
        else
            grid.actions{i}(1) = i + 1;
            grid.actions{i}(2) = i - 5;
            grid.actions{i}(3) = i + 5;
        end
        grid.actions{i}(4) = NaN;
        grid.Q{i}(4) = NaN;
    else
        grid.actions{i}(1) = i - 1;
        grid.actions{i}(2) = i + 1;
        grid.actions{i}(3) = i - 5;
        grid.actions{i}(4) = i + 5;
    end
end

clear i; clear j;  clear k;
end