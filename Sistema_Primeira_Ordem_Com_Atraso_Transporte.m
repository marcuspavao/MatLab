
%pkg load io %Importando funções implementadas no pacote io
%pkg load control %Importando funções implementadas no pacote control

%Importando os valores de Tempo e Temperatura da planilha dados1a_ordem.xlsx
Tempo = xlsread('termoparK-degrau25grausCelsius.xlsx', 1, 'A2:A202');
Temperatura = xlsread('termoparK-degrau25grausCelsius.xlsx', 1, 'B2:B202');

%Função para determinar de forma aproximada o atraso de transporte.
Atraso_Transporte = 0;
for y = 1:201
  if (Temperatura(y,1) == 25)
    Atraso_Transporte = Tempo(y,1);
  end
end

Atraso_Transporte

%Função para determinar de forma aproximada a constante de tempo.
Valor_Final = 0.632*(Temperatura(201,1) - Temperatura(1,1));
Constante_Tempo = 0;
for y = 1:201
  if (Temperatura(y,1) <= (Valor_Final + 25))
    Constante_Tempo = Tempo(y,1);
  end
end

Constante_Tempo

K = (Temperatura(201,1)- 25)/Temperatura(1,1) %Ganho estático do sensor.

num = [ K ];
den = [ Constante_Tempo 1 ];
FT = tf(num,den,'InputDelay',Atraso_Transporte) %Função de transferência de primeira ordem com atraso de transporte.
t = 0:1:200;
AmpDegrau = stepDataOptions('StepAmplitude',25,'InputOffset',25);
step(FT,AmpDegrau,t);

hold
plot(Tempo, Temperatura, 'b');
step(FT,AmpDegrau,t,'g');
title('Gr�fico com os dados medidos e os simulados');
xlabel('Tempo');
ylabel('Temperatura (�C)');

