clear;
clc;

dist_mat = load('mat_distancias.dat');  % Matriz das distâncias
n_cities = length(dist_mat)-1;          % Número de cidades

pop_size = 200;     % Tamanho da população
n_generation = 500;  % Numero de gerações
prob = 0.1;          % Probabilidade da mutação

% Gera a população inicial (rotas aleatórias) 
pop = zeros(pop_size,n_cities); 
for i=1:pop_size
    pop(i,:)=randperm(n_cities);
end

for generation = 1:n_generation   % Loop das gerações
    
    % Calcula a distância total de cada individuo da população
    [popSize, n_cities_2] = size(pop);
    for i = 1:popSize
        d = dist_mat(pop(i,end),pop(i,1)); 
        for k = 2:n_cities_2
            d = d + dist_mat(pop(i,k-1),pop(i,k));
        end
        dist(i) = d;
    end
    
    % Calcula o fitness para cada individuo da população
    pop_dist = dist;
    fitness = 1./pop_dist;
   
    % Acha a melhor(menor) rota e distância
    best_dist = min(pop_dist); 
    best_route = pop(best_dist, :);      
    
    % Seleciona os individuos por competição
    popSize = size(pop,1);
    % Gera 2 sets de população de forma aleatória
    i1 = ceil(popSize*rand(1,pop_size) );
    i2 = ceil(popSize*rand(1,pop_size) );
    % Compara o fitness e seleciona o fitter
    I = i1.*( fitness(i1)>=fitness(i2) ) + i2.*( fitness(i1)< fitness(i2) );
    popselected = pop(I,:);
    pop = popselected;
    
    % Crossover de mapeamento parcial
    pop = crossover(pop);
    
    % Mutação por permutação
    pop = mutation(pop, prob);
   
    % Salva elitismo(melhor rota) para as gerações seguintes
    pop = [best_route; pop];
end

% Retorna a melhor rota e o custo
[min_dist, best_dist]=min(pop_dist); 
best_route = pop(best_dist, :);

fprintf('Com custo de:  %d\n', min_dist);
fprintf('A melhor rota encontrada foi:\n');
disp(best_route);

