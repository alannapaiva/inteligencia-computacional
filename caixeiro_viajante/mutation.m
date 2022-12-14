function children = mutation(parents, probmutation)

[popSize, numberofcities] = size(parents);
children = parents;
for k=1:popSize
    if rand < probmutation
       InsertPoints = ceil(numberofcities*rand(1,2));
       I = min(InsertPoints);  J = max(InsertPoints);
       % Troca duas cidades
       children(k,[I J]) = parents(k,[J I]);
    end
end
