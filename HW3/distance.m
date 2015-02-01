function [ travel, fit ] = distance( mutated, cities, N, length )

for i= 1:N
    for j= 1:(length)
        c1x= cities(mutated(i,j),1);
        c2x= cities(mutated(i,j+1),1);
        c1y= cities(mutated(i,j),2);
        c2y= cities(mutated(i,j+1),2);
        d=sqrt((c1x-c2x)^2+(c1y-c2y)^2);
        magnitude(j)=d;
    end
    travel(i)=sum(magnitude);
    fit(i)=1/sum(travel(i));

end

travel=travel';
fit=fit';

end

