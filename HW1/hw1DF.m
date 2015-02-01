%%  Block 1

clear all
close all
home

nrows = 5;
ncols = 10;
apos = 23;
tpos = 49;

[grid] = populate(nrows, ncols, apos, tpos);

trials = 50;
count1 = 1;
movecounter = zeros(1, trials);

for i = 1:trials
   endgame = 0;
   count2 = 1;
   apos = 23;
   tpos = 49;
   grid.map(apos) = -100;
   grid.map(tpos) = 100;
   figure(count1);
   while endgame ~= 1
       rewards = zeros(nrows, ncols) - 2;
       rewards(tpos) = 100;
       grid.map(tpos) = -1; grid.map(apos) = -1;
       tpos = randactions(grid, tpos);
       %apos = randactions(grid, apos);
       [grid, apos] = qlearn(apos, tpos, grid, rewards, count2);
       if tpos == apos
           tries = count2 + 1;
           Caught = ['Trial ',num2str(count1),': CAUGHT!!  It took ',num2str(tries),' tries.'];
           disp(Caught);
           endgame = 1;
           clear Caught; clear tries;
       else
           grid.map(tpos) = 100; grid.map(apos) = -100;
           imagesc(grid.map);
           drawnow;
       end
       count2 = count2 + 1;
   end
   close 
   count1 = count1 + 1;
   movecounter(i) = count2;
end

close all;

%% Block 2

clear all
close all
home

nrows = 5;
ncols = 10;
apos = 23;
tpos = 49;

[grid] = populate(nrows, ncols, apos, tpos);

trials = 1000;
count1 = 1;
movecounter = zeros(1, trials);

for i = 1:trials
   endgame = 0;
   count2 = 1;
   apos = 23;
   tpos = 49;
   grid.map(apos) = -100;
   grid.map(tpos) = 100;
   figure(count1);
   while endgame ~= 1
       rewards = zeros(nrows, ncols) - 2;
       rewards(tpos) = 100;
       grid.map(tpos) = -1; grid.map(apos) = -1;
       tpos = targetsmart1(grid, tpos, apos);
       [grid, apos] = qlearn(apos, tpos, grid, rewards, count2);
       grid.map(tpos) = 100; grid.map(apos) = -100;
       imagesc(grid.map);
       drawnow;
       if tpos == apos
           tries = count2 + 1;
           Caught = ['CAUGHT!!  It took ', num2str(tries), ' tries.'];
           disp(Caught);
           endgame = 1;
           clear Caught; clear tries;
       end
       imagesc(grid.map);
       drawnow;
       count2 = count2 + 1;
   end
   count1 = count1 + 1;
   movecounter(i) = count2;
end

close all;

%% Block 3

clear all
close all
home

nrows = 5;
ncols = 10;
a1pos = 23;
a2pos = 23;
tpos = 49;

[grid] = populate2(nrows, ncols, a1pos, a2pos, tpos);

trials = 1000;
count1 = 1;
movecounter = zeros(1, trials);

for i = 1:trials
   endgame = 0;
   count2 = 1;
   a1pos = 23;
   a2pos = 23;
   tpos = 49;
   grid.map(a1pos) = -100;
   grid.map(a2pos) = -100;
   grid.map(tpos) = 100;
   figure(count1);
   while endgame ~= 1
       rewards = zeros(nrows, ncols) - 2;
       rewards(tpos) = 100;
       grid.map(tpos) = -1; grid.map(a1pos) = -1; grid.map(a2pos) = -1;
       tpos = targetsmart2(grid, tpos, a1pos, a2pos);
       [grid, a1pos] = qlearn(a1pos, tpos, grid, rewards, count2);
       [grid, a2pos] = qlearn(a2pos, tpos, grid, rewards, count2);
       grid.map(tpos) = 100; grid.map(a1pos) = -100; grid.map(a2pos) = -100;
       imagesc(grid.map);
       drawnow;
       if tpos == a1pos || tpos == a2pos
           tries = count2 + 1;
           Caught = ['CAUGHT!!  It took ', num2str(tries), ' tries.'];
           disp(Caught);
           endgame = 1;
           clear Caught; clear tries;
       end
       imagesc(grid.map);
       drawnow;
       count2 = count2 + 1;
   end
   count1 = count1 + 1;
   movecounter(i) = count2;
end

close all;