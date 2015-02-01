function [zrel] = pythag(xold, yold, xnew, ynew)
    zrel = sqrt(abs(xold - xnew) ^ 2 + abs(yold - ynew) ^ 2);

end