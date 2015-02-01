function [ act ] = actions(grid, loc)

x = [grid.action1(loc) grid.action2(loc)];

if ~isnan(grid.action3(loc))
    x = horzcat(x,grid.action3(loc));
end
if ~isnan(grid.action4(loc))
    x = horzcat(x,grid.action4(loc));
end

act = randsample(x,1);

end
