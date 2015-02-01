function [ move ] = moves(reward, nights, week)

    epsilon = 1;
    r = randi(100,1,1);
    [zed, move] = max(reward);
    if r == epsilon || week == 1
        move = randi([1,nights], 1);
    end


end