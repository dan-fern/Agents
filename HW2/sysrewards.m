function [ sysreward ] = sysrewards(sysreward, i, week, length, b)

sysreward = sysreward(i, week) + (length * exp(-length / b)); 

end