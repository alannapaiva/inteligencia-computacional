function children = crossover(parents)

[popSize, numberofcities] = size(parents);    
children = parents; % Filhos

for i = 1:2:popSize % Contagem
    parent1 = parents(i+0,:);  child1 = parent1;
    parent2 = parents(i+1,:);  child2 = parent2;
    % Escolhe dois pontos aleatórios para corte
    InsertPoints = sort(ceil(numberofcities*rand(1,2)));
    for j = InsertPoints(1):InsertPoints(2)
        if parent1(j)~=parent2(j)
            child1(child1==parent2(j)) = child1(j);
            child1(j) = parent2(j);
            
            child2(child2==parent1(j)) = child2(j);
            child2(j) = parent1(j);
        end
    end
    % Gera dois filhos:
    children(i+0,:)=child1;     
    children(i+1,:)=child2;
end

