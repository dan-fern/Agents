function [ reward ] = rewards(length, b)

    reward = length * exp(-length / b);

end