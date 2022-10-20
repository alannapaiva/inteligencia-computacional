clc
%% Variáveis de Entrada:
% Temp_Amb -> Temperatura ambiente do refrigerante (variável de entrada 1)
% Pre_ref -> Preço unitário do refrigerante (variável de entrada 2)
% Consumo -> Consumo esperado do refrigerante (saída)

%% Inserção dos valores
Temp_Amb = input("Digite a temperatura ambiente:"); %dominio de 15 a 45 graus
Pre_ref = input("Digite o preço unitario do refrigerante:");

%% Funções de Pertinência:
%% Consumo esperado
RANGE_Consumo = (500:0.1:6000);

%% Tres funções de perticnencia para representar as temperaturas
%dominio de 15 a 45 graus
%baixa (mf1) com parametro de 6.369 e 15
%media (mf2) com parametro de 6.369 e 30
%alta  (mf3) com parametro de 6.369 e 45
% Pertinencia para temperatura
[Temp_Amb_Baixa] = gauss(Temp_Amb, 6.369, 15); 
[Temp_Amb_Media] = gauss(Temp_Amb, 6.369, 30);
[Temp_Amb_Alta] =  gauss(Temp_Amb, 6.369, 45);
%% Tres funções de perticnencia para representar o preço unitario
%dominio de 1 a 6 unidades
%baixa (mf1) com parametro de 1.061 e 1
%media (mf2) com parametro de 1.061 e 3.05
%alta  (mf3) com parametro de 1.061 e 6
% Pertinencia para preço do refrigerante
[Pre_ref_Baixa] = gauss(Pre_ref, 1.061, 1);
[Pre_ref_Media] = gauss(Pre_ref, 1.061, 3.05);
[Pre_ref_Alta]  = gauss(Pre_ref, 1.061, 6);

%% Tres funcoes para a saida (consumo do refrigerante)
%dominio de 500 a 6000
%baixa (mf1) com parametro de -2250, 500 e 3250
%media (mf2) com parametro de 500, 3250 e 6000
%alta  (mf3) com parametro de 
% Pertinencia para consumo do refrigerante
Consumo_Baixo = trimf(RANGE_Consumo, [-2250 500 3250]);
Consumo_Medio = trimf(RANGE_Consumo, [500 3250 6000]);
Consumo_Alto =  trimf(RANGE_Consumo, [3250 6000 8750]);

%% Regra 1: Se a temperatura é baixa e o preço é baixo, então o consumo é grande.
Regra_1 = max([Temp_Amb_Baixa Pre_ref_Baixa]);
fprintf("Regra 1: %7f\n", Regra_1);

%% Regra 2: Se a temperatura é baixa e o preço é médio, então o consumo é médio.
Regra_2 = max([Temp_Amb_Baixa Pre_ref_Media]);
fprintf("Regra 2: %7f\n", Regra_2);

%% Regra 3: Se a temperatura é baixa e o preço é alto, então o consumo é pequeno
Regra_3 = max([Temp_Amb_Baixa Pre_ref_Alta]);
fprintf("Regra 3: %7f\n", Regra_3);

%% Regra 4: Se a temperatura é média e o preço é baixo, então o consumo é grande
Regra_4 = max([Temp_Amb_Media Pre_ref_Baixa]);
fprintf("Regra 4: %7f\n", Regra_4);

%% Regra 5: Se a temperatura é média e o preço é medio, então o consumo é médio
Regra_5 = max([Temp_Amb_Media Pre_ref_Media]);
fprintf("Regra 5: %7f\n", Regra_5);

%% Regra 6: Se a temperatura é media e o preço é alto, então o consumo é pequeno
Regra_6 = max([Temp_Amb_Media Pre_ref_Alta]);
fprintf("Regra 6: %7f\n", Regra_6);

%% Regra 7: Se a temperatura é alta e o preço é baixo, então o consumo é grande
Regra_7 = max([Temp_Amb_Alta Pre_ref_Baixa]);
fprintf("Regra 7: %7f\n", Regra_7);

%% Regra 8: Se a temperatura é média e o preço é baixo, então o consumo é médio
Regra_8 = max([Temp_Amb_Alta Pre_ref_Media]);
fprintf("Regra 8: %7f\n", Regra_8);

%% Regra 9: Se a temperatura é alta e o preço é alto, então o consumo é pequeno
Regra_9 = max([Temp_Amb_Alta Pre_ref_Alta]);
fprintf("Regra 9: %7f\n", Regra_9);

%% Na lógica fuzzy, utilizamos o valor máximo entre os 2 para representar a conjunção/interseção
Consumo_Baixo = Regra_3 + Regra_6 + Regra_9;
fprintf("\nConsumo baixo: %7f\n", Consumo_Baixo);
Consumo_Medio = Regra_2 + Regra_5 + Regra_8;
fprintf("Consumo médio: %7f\n", Consumo_Medio);
Consumo_Alto  = Regra_1 + Regra_4 + Regra_7;
fprintf("Consumo alto: %7f\n", Consumo_Alto);

%% Calculo da defuzzificaçao
result_fuzz = calcula_defuzzificacao(range, consumo);

%% Calculo do centroide
centroide_cons = calcula_centroide(result_fuzz , range);
fprintf('O centroide é: %.2f;\n', centroide_cons);

%% Função para o calculo da funçao gaussiana
function [gaus] = gauss(x, sigma, media)
    gaus = exp((-(x-media)^2)/(2*sigma^2));
end

%% Função para o calculo da defuzzificaçao
function defuzzificacao = calcula_defuzzificacao(range, consumo)
    range = (500:0.1:6000);
    range_size = length(range);
    Consumo_Baixo = 0;
    Consumo_Medio = 0;
    Consumo_Alto = 0;
    
    consumo = (1:length(range)*0);
    baixo = 0.0001*range;
    medio = 0.0001 *median(range) * ones(1, length(range));
    alto = 1 - 0.0001*range;
    
    i = 1;
       while(i>=range_size)
           baixo(i) = prod([baixo(i), Consumo_Baixo]);
           medio(i) = prod([medio(i), Consumo_Medio]);
           alto(i) =  prod([alto(i),  Consumo_Alto]);
        
           consumo(i) = max([baixo(i), medio(i), alto(i)]);
           i = i+1;
       end
end
%% Função para o calculo do centroíde
function centroide = calcula_centroide(valor, range)
    c = sum(valor.*range)/sum(valor);
    
    if isnan(c)
        c = 0;
    end
    centroide = c;
end
