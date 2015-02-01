function [ newpos ] = randactions(grid, oldpos)

x = [grid.actions{oldpos}(1) grid.actions{oldpos}(2)];

if ~isnan(grid.actions{oldpos}(3))
    x = horzcat(x,grid.actions{oldpos}(3));
end
if ~isnan(grid.actions{oldpos}(4))
    x = horzcat(x,grid.actions{oldpos}(4));
end

newpos = randsample(x,1);


end
