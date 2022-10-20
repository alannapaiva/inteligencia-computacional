clc
%% Importaçao dos dados
   D = [122 139 0.115;
       114 126 0.120;
       086 090 0.105;
       134 144 0.090;
       146 163 0.100;
       107 136 0.120;
       068 061 0.105;
       117 062 0.080;
       071 041 0.100;
       098 120 0.115];

%% Inicializaçao dos vetores das variáveis de entrada e saída:
x1 = D(:,1); % variaveis regressoras da primeira coluna
x2 = D(:,2); % variaveis regressoras da segunda coluna
y =  D(:,3); % variavel dependente

%% Determinar os coeficientes de regressão múltipla (plano)
%% Calculo dos coeficientes de regressão:
    X= ones (10,3); % 10 linhas e 3 colunas
    i=1;
    while (i <= 10)   
        X(i) = 1;
        X(10+i) = x1(i); 
        X(20+i) = x2(i);
        i=i+1;
    end
    
%%  Calculo do vetor de coeficiente Beta:
    Beta = inv(((X.')*X)) * ((X.')*y);
    
%% Plotagem dos Gráficos:
   plot3 (x1, x2, y, '*m');
   hold on;
   grid on;
   [x1,x2] = meshgrid(40:1:170,40:1:170);
   yest = Beta(1) + Beta(2).*(x1) + Beta(3).*(x2);
   mesh (x1,x2, yest);

%% Variável de resposta
y_chapeuzinho = X*Beta;

%% Calculo de R2
SQe = sum((y - y_chapeuzinho).^2);
Syy = sum((y - mean(y)).^2);
 
% Coeficiente de Determinação de Regrassão Múltipla
R2 = 1 - ((SQe)/(Syy));
fprintf('\nR2 : %.7f\n', R2);

