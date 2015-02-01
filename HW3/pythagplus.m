function [travel, fit] = pythagplus(mutants, cities, pop, length)

for i = 1 : pop
    for j = 1 : length
        xold = cities(mutants(i, j), 1);
        yold = cities(mutants(i, j), 2);
        xnew = cities(mutants(i, j + 1), 1);
        ynew = cities(mutants(i, j + 1), 2);
        zrel(j) = sqrt(abs(xold - xnew) ^ 2 + abs(yold - ynew) ^ 2);
    end
    travel(i) = sum(zrel);
    fit(i) = 1 / sum(travel(i));
end
travel = travel';
fit = fit';

end

