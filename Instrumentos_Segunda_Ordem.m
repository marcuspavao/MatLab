%%clc

%pkg load io %Importando funções implementadas no pacote io

%Importando os valores de Tempo e q0 da planilha dados2a_ordem.xlsx
Tempo = xlsread('dados2a_ordem.xlsx', 1, 'A2:A142');
q0 = xlsread('dados2a_ordem.xlsx', 1, 'B2:B142');

plot(Tempo, q0, 'g');
title('Resposta temporal do sistema de segunda ordem');

A = q0(141,1) %O valor de "A" foi encontrado pegando o último valor de q0, pois nessa situação o sistema começa a entrar na faixa de regime permanente.

Val_Max_q0 = max(q0) %Valor máximo obtido no conjunto de dadas "q0".

a = Val_Max_q0 - A %O valor de "a" foi encontrado pegando o maior valor da lista "qo" e subtraindo o valor de "A".

%Função criada com o intuito de encontrar o período T conforme apresentado pelo gráfico do sistema de segunda ordem.
cont = 0;
temp_inicial = 0;
temp_final = 0;
for y = 1:141
  if (q0(y,1) >= 1 && cont == 0)
    cont = 1;
  end
  if (q0(y,1) <= 1 && cont == 1)
    temp_inicial = Tempo(y,1);
    cont = 2;
  end
  if (q0(y,1) >= 1 && cont == 2)
    cont = 3;
  end
  if (q0(y,1) <= 1 && cont == 3)
    temp_final = Tempo(y,1);
    cont = 4;
  end
end

T = temp_final - temp_inicial %Valor aproximado para o período T.

Dzeta = ((1)/((pi/log(a/A))^2 + 1))^(0.5) %Valor para o quociente de amortecimento
Wn = (2*pi)/(T*(1 - Dzeta^2)^(0.5)) %Valor para a frequência natural não amortecida.

