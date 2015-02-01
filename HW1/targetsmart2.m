function [ tpos ] = targetsmart2(grid, tpos, a1pos, a2pos)

[a1y, a1x] = ind2sub(size(grid.map), a1pos);
[a2y, a2x] = ind2sub(size(grid.map), a2pos);
[ty, tx] = ind2sub(size(grid.map), tpos);

pos = cell(1, 4);
if grid.action(tpos) == 4
    pos{1} = [(tx - 1), ty];
    pos{2} = [tx, (ty + 1)];
    pos{3} = [tx, (ty - 1)];
    pos{4} = [(tx + 1), ty];
elseif grid.action(tpos) == 3
    if tpos == 2 || tpos == 3 || tpos == 4
        pos{1} = [(tx + 1), ty];
        pos{2} = [tx, (ty + 1)];
        pos{3} = [tx, (ty - 1)];
    elseif tpos==10 || tpos==15 || tpos==20 || tpos==25 || tpos==30 || tpos==35 || tpos==40 || tpos==45
        pos{1} = [(tx + 1), ty];
        pos{2} = [(tx + 1), ty];
        pos{3} = [tx, (ty - 1)];
    elseif tpos == 47 || tpos == 48 || tpos == 49
        pos{1} = [(tx - 1), ty];
        pos{2} = [tx, (ty + 1)];
        pos{3} = [tx, (ty - 1)];
    else
        pos{1} = [(tx + 1), ty];
        pos{2} = [(tx + 1), ty];
        pos{3} = [tx, (ty + 1)];
    end
    pos{4} = [NaN, NaN];
else
    if tpos == 1 
        pos{1} = [(tx + 1), ty];
        pos{2} = [tx, (ty + 1)];
    elseif tpos == 5
        pos{1} = [(tx + 1), ty];
        pos{2} = [tx, (ty - 1)];
    elseif tpos == 46 
        pos{1} = [(tx - 1), ty];
        pos{2} = [tx, (ty + 1)];
    else
        pos{1} = [(tx - 1), ty];
        pos{2} = [tx, (ty - 1)];
    end
    pos{3} = [NaN, NaN];
    pos{4} = [NaN, NaN];
end

if abs(pos{1}(1) - a1x) > abs(tx - a1x) || abs(pos{1}(2) - a1y) > abs(ty - a1y) && abs(pos{1}(1) - a2x) > abs(tx - a2x) || abs(pos{1}(2) - a2y) > abs(ty - a2y)
    tpos = sub2ind(size(grid.map), pos{1}(2), pos{1}(1));
elseif abs(pos{2}(1) - a1x) > abs(tx - a1x) || abs(pos{2}(2) - a1y) > abs(ty - a1y) && abs(pos{1}(1) - a2x) > abs(tx - a2x) || abs(pos{1}(2) - a2y) > abs(ty - a2y)
    tpos = sub2ind(size(grid.map), pos{2}(2), pos{2}(1));
elseif abs(pos{3}(1) - a1x) > abs(tx - a1x) || abs(pos{3}(2) - a1y) > abs(ty - a1y) && abs(pos{1}(1) - a2x) > abs(tx - a2x) || abs(pos{1}(2) - a2y) > abs(ty - a2y)
    tpos = sub2ind(size(grid.map), pos{3}(2), pos{3}(1));
elseif abs(pos{4}(1) - a1x) > abs(tx - a1x) || abs(pos{4}(2) - a1y) > abs(ty - a1y) && abs(pos{1}(1) - a2x) > abs(tx - a2x) || abs(pos{1}(2) - a2y) > abs(ty - a2y)
    tpos = sub2ind(size(grid.map), pos{4}(2), pos{4}(1));
else 
    tpos = randactions(grid, tpos);
end

end
