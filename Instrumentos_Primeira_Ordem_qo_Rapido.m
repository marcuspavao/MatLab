%clear all
%clc

%pkg load io %Importando funções implementadas no pacote io

%Importando os valores de Tempo e q0_Rapido da planilha dados1a_ordem.xlsx
Tempo = xlsread('dados1a_ordem.xlsx', 1, 'A2:A52');
q0_Rapido = xlsread('dados1a_ordem.xlsx', 1, 'C2:C52');
Valor_Final = xlsread('dados1a_ordem.xlsx', 1, 'C52');

A = xlsread('dados1a_ordem.xlsx', 1, 'A2:A51');
B = diff(q0_Rapido); %A função retorna um vetor de comprimento m-1, os elementos de A são as diferenças entre os elementos adjacentes de q0_Rapido.
C = diff(Tempo);

%Laço de repetição para criar uma matriz de sensibilidade.
S = zeros(50,1); %Define vetor com elementos inicias iguais a zero.
for y = 1:50
  S(y,1) = B(y,1)/C(y,1);
end

%Laço de repetição para criar a matriz Z.
Z = zeros(51,1); %Define vetor com elementos inicias iguais a zero.
for x = 1:51
  Z(x,1) = log(1 - q0_Rapido(x,1));
end

subplot(3,1,1) %Define uma matriz com 3 linhas e uma coluna para plotar os três gráficos na mesma tela.
plot(Tempo,q0_Rapido,'g'); %Primeiro gráfico.
title('Resposta R�pida');
subplot(3,1,2)
plot(A,S,'b'); %Segundo gráfico.
title('Sensibilidade R�pida');
subplot(3,1,3)
plot(Tempo,Z,'r'); %Terceiro gráfico.
title('Z em fun��o do tempo, para sensibilidade est�tica (K) igual a 1');

Cat_Oposto = xlsread('dados1a_ordem.xlsx', 1, 'A52') - xlsread('dados1a_ordem.xlsx', 1, 'A2');
Cat_Adjacente = Z(51,1) - Z(1,1);
Constante_Tempo_Rapida = -(Cat_Oposto/Cat_Adjacente)

