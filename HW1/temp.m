%function [ Q ] = qlearn(apos, tpos, grid, rewards, trials)
alpha = 0.1;  % learn rate
gamma = 0.2;  % discount
epsilon = 10;
maxR = 100;
caught = 0;
[ay, ax] = ind2sub(size(grid.map), apos);
[ty, tx] = ind2sub(size(grid.map), tpos);
rx = 10 + ax - tx;
ry = 5 + ay - ty;
rpos = sub2ind(size(grid.Q),ry,rx);
[VMax, IMax] = max(grid.Q{rpos}(:));

pos = cell(1, 4);
pos{1} = [(ax - 1), ay];
pos{2} = [ax, (ay + 1)];
pos{3} = [ax, (ay - 1)];
pos{4} = [(ax + 1), ay];

for i = 1:length(pos);
    if pos{i}(1) == tx && pos{i}(2) == ty
            fprintf('CAUGHT \n')
            grid.Q{tpos}(i) = grid.Q{tpos}(i) + maxR;
            finposx = 1;
            finposy = 1;
            caught = 1;
            %[VMax, IMax] = nanmax(grid.Q{rpos}(:)) % Need for Qlearning
    else
        figure(2)
        for j = 1:length(loc);
            grid.Q{rpos}(i) = grid.Q{rpos}(i) + alpha * (grid.Reward(apos) + gamma * VMax - grid.Q{rpos}(i));
        end
        if caught == 0
            finpos = pos{IMax};
            if randi([1, epsilon], 1) == 1 || VMax == 0;
                finpos = pos{randi([1, 4], 1)};
            end
            if finpos(1) == 0;
                finpos(1) = 2;
            end
            if finpos(1) == 11;
                finpos(1) = 9;
            end
            if finpos(2) == 0;
                finpos(2) = 2;
            end
            if finpos(2) == 6;
                finpos(2) = 4;
            end
            finposx= finpos(1); 
            finposy= finpos(2);
        end
    end
end
figure(3)
%if trials < 10 && caught == 0;
 %   [finposx, finposy] = target_pos(apx, apy);
%end

%Q = old + alpha * (reward + gamma * maxR - old);

%end

