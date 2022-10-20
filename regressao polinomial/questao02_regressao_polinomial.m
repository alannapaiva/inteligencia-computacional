clc
%% Importaçao dos dados
load aerogerador.dat;

%% Declaraçao a variavel dependente de X
X = aerogerador(:,1);
%% Declaraçao variavel independente de y
y = aerogerador(:,2);
%% Plotagem do gráfico da regressao linear simples
plot(X, y, 'm*');
hold on

%% CÁLCULO DA REGRESSÃO
%% Matriz de Regressao Simples
n = length(X); %Extrai o tamanho do vetor X.
X_mat = [ones(length(X), 1) X];
% beta = (X_mat'*X_mat)^(-1)*X_mat'*y; %Estimativa de quadadros mínimos
% y_chapeuzinho = beta(1) + (beta(2)*X) + (beta(3) * (X.^nivel_do_grau)); %Determinação para polinômio de segundo grau.

%% Fazendo o calculo da Regressao polinomial para cada grau proposto
%% Calculo da Regressao polinomial de grau 2
X_mat_2 = [X_mat X.^2];
beta_2 = (X_mat_2'*X_mat_2)^(-1)*X_mat_2'*y;
y_chapeuzinho_2 = beta_2(1) + (beta_2(2)*X) + (beta_2(3) * (X.^2));
plot(X, y_chapeuzinho_2, 'k-');

%% Calculo da Regressao polinomial de grau 3
X_mat_3 = [X_mat_2 X.^3];
beta_3 = (X_mat_3'*X_mat_3)^(-1)*X_mat_3'*y;
y_chapeuzinho_3 = beta_3(1) + (beta_3(2)*X) + (beta_3(3) * (X.^2)) + (beta_3(4) * (X.^3));
plot(X, y_chapeuzinho_3, 'r-');

%% Calculo da Regressao polinomial de grau 4
X_mat_4 = [X_mat_3 X.^4];
beta_4 = (X_mat_4'*X_mat_4)^(-1)*X_mat_4'*y;
y_chapeuzinho_4 = beta_4(1) + (beta_4(2)*X) + (beta_4(3) * (X.^2)) + (beta_4(4) * (X.^3)) + (beta_4(5) * (X.^4));
plot(X, y_chapeuzinho_4, 'g-');

%% Calculo da Regressao polinomial de grau 5
X_mat_5 = [X_mat_4 X.^5];
beta_5 = (X_mat_5'*X_mat_5)^(-1)*X_mat_5'*y;
y_chapeuzinho_5 = beta_5(1) + (beta_5(2)*X) + (beta_5(3) * (X.^2)) + (beta_5(4) * (X.^3)) + (beta_5(5) * (X.^4)) + (beta_5(6) * (X.^5));
plot(X, y_chapeuzinho_5, 'y-');

%% Calculo da Regressao polinomial de grau 6
X_mat_6 = [X_mat_5 X.^6];
beta_6 = (X_mat_6'*X_mat_6)^(-1)*X_mat_6'*y;
y_chapeuzinho_6 = beta_6(1) + (beta_6(2)*X) + (beta_6(3) * (X.^2)) + (beta_6(4) * (X.^3)) + (beta_6(5) * (X.^4)) + (beta_6(6) * (X.^5)) + (beta_6(7) * (X.^6));
plot(X, y_chapeuzinho_6, 'b-');

%% Calculo da Regressao polinomial de grau 7
X_mat_7 = [X_mat_6 X.^7];
beta_7 = (X_mat_7'*X_mat_7)^(-1)*X_mat_7'*y;
y_chapeuzinho_7 = beta_7(1) + (beta_7(2)*X) + (beta_7(3) * (X.^2)) + (beta_7(4) * (X.^3)) + (beta_7(5) * (X.^4)) + (beta_7(6) * (X.^5)) + (beta_7(7) * (X.^6)) + (beta_7(8) * (X.^7));
plot(X, y_chapeuzinho_7, 'c-');

title('Regressão Polinomial');
legend('Base de Dados', 'Grau 2', 'Grau 3', 'Grau 4', 'Grau 5', 'Grau 6', 'Grau 7','Location','northwest');

%% AVALIAÇAO DOS MODELOS
% O coeficiente de determinação R² também é usado na Regressão Múltiplca como medida de adequaçao do modelo.
% E o acrescimo de uma variável ao modelo causa sempre um aumento em R², porém, o valor alto não quer dizer que o modelo seja eficiente.
% Uma fórmula para calculá-lo é : R²aj = 1 - (1-R²)*(n-1/n-k), em que n é o número de amostras e k é o número total de variáveis.

% Formula para o Calculo de R2 
% SQe = sum((y - y_chapeuzino).^2);
% Syy = sum((y - mean(y)).^2);
% Coeficiente de Determinação de Regrassão Múltipla
% R2 = 1 - (SQe/Syy);

%% Fazendo o calculo de R2 e R2 ajustado para cada grau proposto
%% Calculo de R2 para o grau 2
e = sum((y - y_chapeuzinho_2).^2); %vetor de erros

variancia = sum((y-y_chapeuzinho_2).^2)/ n - 2;

SQe = sum((y - y_chapeuzinho_2).^2);
Syy = sum((y - mean(y)).^2);

%Coeficiente de Determinação de Regrassão Múltipla
R2_2 = 1 - ((SQe)/(Syy));
fprintf('\nR2 para o grau 2: %.7f', R2_2);
% Coeficiente de Determinação Ajustado
R2aj = 1 - ((1 - R2_2) * (length(X)-1)/(length(X) - 3));
fprintf('\nR2 ajustado para o grau 2: %.7f\n', R2aj);

%% Calculo de R2 para o grau 3
SQe = sum((y - y_chapeuzinho_3).^2);
Syy = sum((y - mean(y)).^2);

% Coeficiente de Determinação de Regrassão Múltipla
R2_3 = 1 - ((SQe)/(Syy));
fprintf('\nR2 para o grau 3: %.7f', R2_3);
% Coeficiente de Determinação Ajustado
R2aj = 1 - ((1 - R2_3) * (length(X)-1)/(length(X) - 4));
fprintf('\nR2 ajustado para o grau 3: %.7f\n', R2aj);
%% Calculo de R2 para o grau 4
SQe = sum((y - y_chapeuzinho_4).^2);
Syy = sum((y - mean(y)).^2);

% Coeficiente de Determinação de Regrassão Múltipla
R2_4 = 1 - ((SQe)/(Syy));
fprintf('\nR2 para o grau 4: %.7f', R2_4);
% Coeficiente de Determinação Ajustado
R2aj = 1 - ((1 - R2_4) * (length(X)-1)/(length(X) - 5));
fprintf('\nR2 ajustado para o grau 4: %.7f\n', R2aj);
%% Calculo de R2 para o grau 5
SQe = sum((y - y_chapeuzinho_5).^2);
Syy = sum((y - mean(y)).^2);

% Coeficiente de Determinação de Regrassão Múltipla
R2_5 = 1 - ((SQe)/(Syy)); %Quão encaixado o modelo está aos dados
fprintf('\nR2 para o grau 5: %.7f', R2_5);
% Coeficiente de Determinação Ajustado
R2aj = 1 - ((1 - R2_5) * (length(X)-1)/(length(X) - 6)); 
fprintf('\nR2 ajustado para o grau 5: %.7f\n', R2aj);
%% Calculo de R2 para o grau 6
SQe = sum((y - y_chapeuzinho_6).^2);
Syy = sum((y - mean(y)).^2);

% Coeficiente de Determinação de Regrassão Múltipla
R2_6 = 1 - ((SQe)/(Syy));
fprintf('\nR2 para o grau 6: %.7f', R2_6);
% Coeficiente de Determinação Ajustado
R2aj = 1 - ((1 - R2_6) * (length(X)-1)/(length(X) - 7));
fprintf('\nR2 ajustado para o grau 6: %.7f\n', R2aj);
%% Calculo de R2 para o grau 7
SQe = sum((y - y_chapeuzinho_7).^2);
Syy = sum((y - mean(y)).^2);

% Coeficiente de Determinação de Regrassão Múltipla
R2_7 = 1 - ((SQe)/(Syy));
fprintf('\nR2 para o grau 7: %.7f', R2_7);
% Coeficiente de Determinação Ajustado
R2aj = 1 - ((1 - R2_7) * (length(X)-1)/(length(X) - 8));
fprintf('\nR2 ajustado para o grau 7: %.7f\n', R2aj);
