clear all
close all
home

agents = 30;
bars = 1;
b = 4;
k = 6;

G = cell(bars, agents);
[G{:}] = deal(zeros(1, 6));

trials = 100;
trialcount = 0;
week = 1;
weeks = 1000;
diff = G;

patrons = 0;
diffpatrons = 0;
move = zeros(1, agents);
diffmove = zeros(1, agents);
sysreward = zeros(trials, weeks);
diffsysreward = zeros(trials, weeks);
localreward = zeros(trials, weeks);


for i = 1 : trials
    week = 1;    
    [G{:}] = deal(zeros(bars, k));
    diff = G;
    while week < weeks
        for j = 1 : agents
            move(j) = moves(G{1,j}(:), k, week);
            diffmove(j) = moves(diff{1,j}(:), k, week);
        end
        for j = 1 : k            
            patrons(j) = 0;
            index = [];
            diffpatrons(j) = 0;
            diffindex = [];
            for n = 1 : numel(move)
                if move(n) == j
                    patrons(j) = patrons(j) + 1;
                    index = horzcat(index, n);
                end
                if diffmove(n) == j
                    diffpatrons(j) = diffpatrons(j) + 1;
                    diffindex = horzcat(diffindex, n);
                end
            end
            reward(j) = rewards(patrons(j), b);
            diffreward(j) = rewards(diffpatrons(j), b);
            sysreward(i, week) = sysrewards(sysreward, i, week, patrons(j), b);
            diffsysreward(i, week) = sysrewards(diffsysreward, i, week, diffpatrons(j), b); 
            localreward(i, week) = reward(j);
            for n = 1 : numel(index)                
                G{1, index(n)}(j) = reward(j);                
            end 
        end
        for j = 1 : k
            for n = 1 : numel(diffindex)
                diff{1, diffindex(n)}(j) =  diffsysreward(i, week) - diffreward(j);
            end
        end
        if week == 750 && i == trials
            figure(1)
            bar(patrons,1); axis tight; 
            titles = ['System Reward -- Trial: ', num2str(i), ' -- Week: ', num2str(week)];
            title(titles); xlabel('Day of Week'); ylabel('Bar Patrons');
            figure(2)
            bar(diffpatrons,1); axis tight; 
            titles = ['Difference Reward -- Trial: ', num2str(i), ' -- Week: ', num2str(week)];
            title(titles); xlabel('Day of Week'); ylabel('Bar Patrons');
        end
        bar(diffpatrons,1); axis tight; 
        titles = ['Trial: ', num2str(i), ' -- Week: ', num2str(week)];
        title(titles); xlabel('Day of Week'); ylabel('Bar Patrons')
        drawnow
        week = week + 1; 
    end
    i = i + 1;    
end

figure(3)
plot((1:weeks), mean(sysreward), 'r')
hold on
plot((1:weeks), mean(diffsysreward), 'b')
hold on
plot((1:weeks), mean(localreward), 'g')
legend('System','Difference','Local','Location','SouthWest')
set(gca,'YLim',[0 8]); set(gca,'YTick',[0:1:8]);
title('Part A: K = 6, agents = 30');

%%
clear all

agents = 50;
bars = 1;
b = 4;
k = 5;

G = cell(bars, agents);
[G{:}] = deal(zeros(1, 6));

trials = 3;
trialcount = 0;
week = 1;
weeks = 1000;
diff = G;

patrons = 0;
diffpatrons = 0;
move = zeros(1, agents);
diffmove = zeros(1, agents);
sysreward = zeros(trials, weeks);
diffsysreward = zeros(trials, weeks);
localreward = zeros(trials, weeks);


for i = 1 : trials
    week = 1;    
    [G{:}] = deal(zeros(bars, k));
    diff = G;
    while week < weeks
        for j = 1 : agents
            move(j) = moves(G{1,j}(:), k, week);
            diffmove(j) = moves(diff{1,j}(:), k, week);
        end
        for j = 1 : k            
            patrons(j) = 0;
            index = [];
            diffpatrons(j) = 0;
            diffindex = [];
            for n = 1 : numel(move)
                if move(n) == j
                    patrons(j) = patrons(j) + 1;
                    index = horzcat(index, n);
                end
                if diffmove(n) == j
                    diffpatrons(j) = diffpatrons(j) + 1;
                    diffindex = horzcat(diffindex, n);
                end
            end
            reward(j) = rewards(patrons(j), b);
            diffreward(j) = rewards(diffpatrons(j), b);
            sysreward(i, week) = sysrewards(sysreward, i, week, patrons(j), b);
            diffsysreward(i, week) = sysrewards(diffsysreward, i, week, diffpatrons(j), b); 
            localreward(i, week) = reward(j);
            for n = 1 : numel(index)                
                G{1, index(n)}(j) = reward(j);                
            end 
        end
        for j = 1 : k
            for n = 1 : numel(diffindex)
                diff{1, diffindex(n)}(j) =  diffsysreward(i, week) - diffreward(j);
            end
        end
        if week == 750 && i == trials
            figure(4)
            bar(patrons,1); axis tight; 
            titles = ['System Reward -- Trial: ', num2str(i), ' -- Week: ', num2str(week)];
            title(titles); xlabel('Day of Week'); ylabel('Bar Patrons');
            figure(5)
            bar(diffpatrons,1); axis tight; 
            titles = ['Difference Reward -- Trial: ', num2str(i), ' -- Week: ', num2str(week)];
            title(titles); xlabel('Day of Week'); ylabel('Bar Patrons');
        end
%         bar(diffpatrons,1); axis tight; 
%         titles = ['Trial: ', num2str(i), ' -- Week: ', num2str(week)];
%         title(titles); xlabel('Day of Week'); ylabel('Bar Patrons')
%         drawnow
        week = week + 1; 
    end
    i = i + 1;    
end

figure(6)
plot((1:weeks), mean(sysreward), 'r')
hold on
plot((1:weeks), mean(diffsysreward), 'b')
hold on
plot((1:weeks), mean(localreward), 'g')
legend('System','Difference','Local','Location','SouthWest')
set(gca,'YLim',[0 6]); set(gca,'YTick',[0:1:6]);
title('Part B: K = 5, agents = 50');
