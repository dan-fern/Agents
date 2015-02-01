%% A* Greedy 

clear all
close all
home

cities1 = csvread('cities1.csv');
cities2 = csvread('cities2.csv');

cities.x1 = cities1(:,1)';
cities.y1 = cities1(:,2)';
cities.x2 = cities2(:,1)';
cities.y2 = cities2(:,2)';

ind1 = 1;
ind2 = 1;
currentcity1 = [cities.x1(ind1) cities.y1(ind1)];
currentcity2 = [cities.x2(ind2) cities.y2(ind2)];
z1 = zeros(1,length(cities1));
z2 = zeros(1,length(cities2));

figure(1)
labels = cellstr( num2str([1:10]') );
for i = 1 : length(cities1)
    z1 = zeros(1,numel(cities.x1));
    for j = 1 : numel(cities.x1)
        z1(j) = pythag(currentcity1(1),currentcity1(2),cities.x1(j),cities.y1(j));
    end
    ind1 = find(z1 == min(z1));
    currentcity1 = [cities.x1(ind1) cities.y1(ind1)];
    plot(currentcity1(1), currentcity1(2), 'ro');
    text(currentcity1(1), currentcity1(2), labels(i), ...
        'VerticalAlignment','bottom','HorizontalAlignment','right')
    set(gca,'XLim',[0 100]); set(gca,'XTick',(0:10:100));
    set(gca,'YLim',[0 100]); set(gca,'YTick',(0:10:100));
    xlabel('Longitude'); ylabel('Latitude'); 
    title('TSP, A* (Greedy): n = 10 cities');
    hold on
    pause(0.1);
    cities.x1(ind1) = [];
    cities.y1(ind1) = [];
end

figure(2)
labels = cellstr( num2str([1:20]') );
for i = 1 : length(cities2)
    z2 = zeros(1,numel(cities.x2));
    for j = 1 : numel(cities.x2)
        z2(j) = pythag(currentcity2(1),currentcity2(2),cities.x2(j),cities.y2(j));
    end
    ind2 = find(z2 == min(z2));
    currentcity2 = [cities.x2(ind2) cities.y2(ind2)];
    plot(currentcity2(1), currentcity2(2), 'ro');
    text(currentcity2(1), currentcity2(2), labels(i), ...
        'VerticalAlignment','bottom','HorizontalAlignment','right')
    set(gca,'XLim',[0 100]); set(gca,'XTick',(0:10:100));
    set(gca,'YLim',[0 100]); set(gca,'YTick',(0:10:100));
    xlabel('Longitude'); ylabel('Latitude'); 
    title('TSP, A* (Greedy): n = 20 cities');
    hold on
    pause(0.1);
    cities.x2(ind2) = [];
    cities.y2(ind2) = [];
end

%%  A* MST

clear all
close all
home

cities1 = csvread('cities1.csv');
cities2 = csvread('cities2.csv');

cities.x1 = cities1(:,1)';
cities.y1 = cities1(:,2)';
cities.x2 = cities2(:,1)';
cities.y2 = cities2(:,2)';

cities.ind1 = 1;
cities.ind2 = 1;
cities.allind1 = [1;2;3;4;5;6;7;8;9;10];
cities.allind2 = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20];
cities.current1 = [cities.x1(cities.ind1) cities.y1(cities.ind1)];
cities.current2 = [cities.x2(cities.ind2) cities.y2(cities.ind2)];

best.path1 = zeros(10, 1);
best.path1(1) = 1;
best.path2 = zeros(20, 1);
best.path2(1) = 1;
z1 = []; Path1 = [];
z2 = []; Path2 = [];
step = 1;

tic
while sum(best.path1(10,:)) == 0
    trials = [];
    for i = 1 : numel(cities.allind1)
        if find(best.path1 == i)
            ...
        else
            trials = horzcat(trials, cities.allind1(i));
        end
    end
    length = numel(trials);
    z1 = horzcat(z1, zeros(10, length));
    Path1 = horzcat(Path1, zeros(10, length));    
    if step ~= 1
        z1(:,best.spot1) = [];
        Path1(:,best.spot1) = [];
        for k = 1 : length
            z1(1:(10-length),size(z1,2)-length+k) = best.col1(1:(10-length));
            Path1(1:(10-length),size(z1,2)-length+k) = best.path1(1:(10-length));
        end
    end
    for j = 1 : length
        Path1(1,j) = 1;
        A = sub2ind(size(z1), (10 - length + 1), (size(z1,2) - length + j));
        Path1(A) = trials(j);
        z1(A) = pythag(cities.current1(1),cities.current1(2),cities.x1(trials(j)),cities.y1(trials(j)));        
    end
    best.spot1 = find(sum(z1) == min(sum(z1)));
    if numel(best.spot1) ~= 1
        best.spot1 = randsample(find(sum(z1) == min(sum(z1))),1);
    end
    best.col1 = z1(:,best.spot1);
    best.path1 = Path1(:,best.spot1);
    cities.ind1 = find(best.path1);
    cities.ind1 = cities.ind1(end);
    cities.current1 = [cities.x1(best.path1(cities.ind1)) cities.y1(best.path1(cities.ind1))];
    step = step + 1;
end
toc
figure(3)
labels = cellstr( num2str([1:10]') );
for i = 1 : numel(cities.allind1)
    plot(cities.x1(best.path1(i)), cities.y1(best.path1(i)), 'ro');
    text(cities.x1(best.path1(i)), cities.y1(best.path1(i)), labels(i), ...
        'VerticalAlignment','bottom','HorizontalAlignment','right');
    xlabel('Longitude'); ylabel('Latitude'); 
    title('TSP (MST): n = 10 cities');
    set(gca,'XLim',[0 100]); set(gca,'XTick',(0:10:100));
    set(gca,'YLim',[0 100]); set(gca,'YTick',(0:10:100));
    hold on
    pause(0.5);
end

tic
step = 1;
while sum(best.path2(20,:)) == 0
    trials = [];
    for i = 1 : numel(cities.allind2)
        if find(best.path2 == i)
            ...
        else
            trials = horzcat(trials, cities.allind2(i));
        end
    end
    length = numel(trials);
    z2 = horzcat(z2, zeros(20, length));
    Path2 = horzcat(Path2, zeros(20, length));    
    if step ~= 1
        z2(:,best.spot2) = [];
        Path2(:,best.spot2) = [];
        for k = 1 : length
            z2(1:(20-length),size(z2,2)-length+k) = best.col2(1:(20-length));
            Path2(1:(20-length),size(z2,2)-length+k) = best.path2(1:(20-length));
        end
    end
    for j = 1 : length
        Path2(1,j) = 1;
        A = sub2ind(size(z2), (20 - length + 1), (size(z2,2) - length + j));
        Path2(A) = trials(j);
        z2(A) = pythag(cities.current2(1),cities.current2(2),cities.x2(trials(j)),cities.y2(trials(j)));        
    end
    best.spot2 = find(sum(z2) == min(sum(z2)));
    if numel(best.spot2) ~= 1
        best.spot2 = randsample(find(sum(z2) == min(sum(z2))),1);
    end
    best.col2 = z2(:,best.spot2);
    best.path2 = Path2(:,best.spot2);
    cities.ind2 = find(best.path2);
    cities.ind2 = cities.ind2(end);
    cities.current2 = [cities.x2(best.path2(cities.ind2)) cities.y2(best.path2(cities.ind2))];
    step = step + 1;
end
toc
figure(4)
labels = cellstr( num2str([1:20]') );
for i = 1 : numel(cities.allind2)
    plot(cities.x2(best.path2(i)), cities.y2(best.path2(i)), 'ro');
    text(cities.x2(best.path2(i)), cities.y2(best.path2(i)), labels(i), ...
        'VerticalAlignment','bottom','HorizontalAlignment','right');
    set(gca,'XLim',[0 100]); set(gca,'XTick',(0:10:100));
    set(gca,'YLim',[0 100]); set(gca,'YTick',(0:10:100));
    xlabel('Longitude'); ylabel('Latitude'); 
    title('TSP (MST): n = 20 cities');
    hold on
    pause(0.5);
end

%%  EA

clear all
close all
home

cities1 = csvread('cities1.csv');
cities2 = csvread('cities2.csv');

cities.x1 = cities1(:, 1)';
cities.y1 = cities1(:, 2)';
cities.x2 = cities2(:, 1)';
cities.y2 = cities2(:, 2)';
tic
paths = [];
trials = 1000;
pop = 50;
length = numel(cities.x1);
generation = 1;

for i = 1 : pop
    paths(i, 1) = 1;    
    paths(i, length + 1) = 1;
    step = randperm(length - 1);
    paths(i, 2 : length) = step + 1;
end

mutants = paths;
[travel, fit] = pythagplus(mutants, cities1, pop, length);
mutants = horzcat(mutants, travel, fit);
paths = mutants;

while (generation ~= trials)
    generation = generation + 1;
    mutants = paths;
    for j = 1 : pop
        chances = randi(5,1,1);
        for k = 1 : chances
            m = randi([2 length], 1);
            n = randi([2 length], 1);
            professorX = mutants(j, m);
            mutants(j, m) = mutants(j, n);
            mutants(j, n) = professorX;
        end
    end
    [travel, fit] = pythagplus(mutants, cities1, pop, length);
    mutants(:, length + 3) = fit;
    mutants(:, length + 2) = travel;
    mutants = vertcat(paths, mutants);
    paths = sortrows(mutants, -1 * length - 3);
    paths = paths(1 : pop, 1 : end);
end

figure (5)
bestpath1 = paths(1,1:11);
labels = cellstr( num2str([1:10]') );
for i = 1 : length
    plot(cities.x1(bestpath1(i)), cities.y1(bestpath1(i)), 'ro');
    text(cities.x1(bestpath1(i)), cities.y1(bestpath1(i)), labels(i), ...
        'VerticalAlignment','bottom','HorizontalAlignment','right')
    set(gca,'XLim',[0 100]); set(gca,'XTick',(0:10:100));
    set(gca,'YLim',[0 100]); set(gca,'YTick',(0:10:100));
    xlabel('Longitude'); ylabel('Latitude'); 
    title('TSP, Evolutionary: n = 10 cities');
    hold on
    pause(0.1);
end
toc

tic
paths = [];
trials = 1000;
pop = 50;
length = numel(cities.x2);
generation = 1;

for i = 1 : pop
    paths(i, 1) = 1;   
    paths(i, length + 1) = 1;
    step = randperm(length - 1);
    paths(i, 2 : length) = step + 1;
end

mutants = paths;
[travel, fit] = pythagplus(mutants, cities2, pop, length);
mutants = horzcat(mutants, travel, fit);
paths = mutants;

while (generation ~= trials)
    generation = generation + 1;
    mutants = paths;
    for j = 1 : pop
        chances = randi(5,1,1);
        for k = 1 : chances
            m = randi([2 length], 1);
            n = randi([2 length], 1);
            professorX = mutants(j, m);
            mutants(j, m) = mutants(j, n);
            mutants(j, n) = professorX;
        end
    end
    [travel, fit] = pythagplus(mutants, cities2, pop, length);
    mutants(:, length + 3) = fit;
    mutants(:, length + 2) = travel;
    mutants = vertcat(paths, mutants);
    paths = sortrows(mutants, -1 * length - 3);
    paths = paths(1 : pop, 1 : end);
end

figure(6)
bestpath2 = paths(1,1:21);
labels = cellstr( num2str([1:20]') );
for i = 1 : length
    plot(cities.x2(bestpath2(i)), cities.y2(bestpath2(i)), 'ro');
    text(cities.x2(bestpath2(i)), cities.y2(bestpath2(i)), labels(i), ...
        'VerticalAlignment','bottom','HorizontalAlignment','right')
    set(gca,'XLim',[0 100]); set(gca,'XTick',(0:10:100));
    set(gca,'YLim',[0 100]); set(gca,'YTick',(0:10:100));
    xlabel('Longitude'); ylabel('Latitude'); 
    title('TSP, Evolutionary: n = 20 cities');
    hold on
    pause(0.1);
end
toc
