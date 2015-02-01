function [ grid, apos, pos ] = qlearn(apos, tpos, grid, rewards, count2)
alpha = 0.1;  % learn rate
gamma = 0.9;  % discount
epsilon = 0.1;
count1 = 1;
caught = 0;

[ay, ax] = ind2sub(size(grid.map), apos);
[ty, tx] = ind2sub(size(grid.map), tpos);

pos = cell(1, 4);
if grid.action(apos) == 4
    pos{1} = [(ax - 1), ay];
    pos{2} = [ax, (ay + 1)];
    pos{3} = [ax, (ay - 1)];
    pos{4} = [(ax + 1), ay];
elseif grid.action(apos) == 3
    if apos == 2 || apos == 3 || apos == 4
        pos{1} = [(ax + 1), ay];
        pos{2} = [ax, (ay + 1)];
        pos{3} = [ax, (ay - 1)];
    elseif apos==10 || apos==15 || apos==20 || apos==25 || apos==30 || apos==35 || apos==40 || apos==45
        pos{1} = [(ax + 1), ay];
        pos{2} = [(ax - 1), ay];
        pos{3} = [ax, (ay - 1)];
    elseif apos == 47 || apos == 48 || apos == 49
        pos{1} = [(ax - 1), ay];
        pos{2} = [ax, (ay + 1)];
        pos{3} = [ax, (ay - 1)];
    else
        pos{1} = [(ax + 1), ay];
        pos{2} = [(ax + 1), ay];
        pos{3} = [ax, (ay + 1)];
    end
    pos{4} = [NaN, NaN];
else
    if apos == 1 
        pos{1} = [(ax + 1), ay];
        pos{2} = [ax, (ay + 1)];
    elseif apos == 5
        pos{1} = [(ax + 1), ay];
        pos{2} = [ax, (ay - 1)];
    elseif apos == 46 
        pos{1} = [(ax - 1), ay];
        pos{2} = [ax, (ay + 1)];
    else
        pos{1} = [(ax - 1), ay];
        pos{2} = [ax, (ay - 1)];
    end
    pos{3} = [NaN, NaN];
    pos{4} = [NaN, NaN];
end
r = randi(100,1,1);

if count2 <= 1
    apos = randactions(grid, apos);
elseif r <= (100 * epsilon)
    apos = randactions(grid, apos);
else
    for j = 1:4
        ind1 = sub2ind(size(grid.map), pos{j}(2), pos{j}(1));
        if caught == 1
            break;
        elseif ind1 == tpos  && pos{j}(1) == tx && pos{j}(2) == ty
            apos = tpos;
            caught = 1;
        elseif caught ~= 1 && count1 ~= 5 && ~isnan(ind1)
            grid.Q{ind1}(j) = grid.Q{apos}(j) + alpha * ...
                (rewards((j)) + gamma * nanmax(grid.Q{ind1}(1:4)) ...
               - grid.Q{apos}(j)); % Qlearn
            count1 = count1 + 1;
            if count1 == 5
                ind2 = find(grid.Q{apos}(1:4) == nanmax(grid.Q{apos}(1:4)));
                if length(ind2) > 1
                    move = randsample(ind2,1);
                else
                    move = ind2;
                end
                apos = sub2ind(size(grid.map), pos{move}(2), pos{move}(1));
                break;
            end
        end
    end
end


end
