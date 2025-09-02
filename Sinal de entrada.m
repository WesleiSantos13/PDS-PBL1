clear; clc; close all;

% ---------- Parâmetros ----------
% Como um computador só trabalha com valores discretos, nunca teremos um sinal contínuo de verdade.
% Mas se usamos uma frequência de amostragem muito maior do que a das senoides do nosso sinal,
%conseguimos representar esse sinal quase como se fosse contínuo → por isso chamamos de “quase-contínuo”.

fs_cont = 50000;     % frequência de "quase-contínuo" (bem alta)
Tend    = 0.01;      % duração do sinal em segundos
t       = 0:1/fs_cont:Tend;   % vetor de tempo contínuo

% ---------- Definição das senoides ----------
f1 = 100;   % frequência 1 em Hz
f2 = 300;   % frequência 2 em Hz
f3 = 600;   % frequência 3 em Hz

sinal1 = sin(2*pi*f1*t);   % senoide 1
sinal2 = 0.7*sin(2*pi*f2*t); % senoide 2 (com amplitude 0.7)
sinal3 = 0.5*sin(2*pi*f3*t); % senoide 3 (com amplitude 0.5)

% Combinação das senoides
x = sinal1 + sinal2 + sinal3;

% ---------- Plot ----------
figure;
plot(t, x);
xlabel("Tempo (s)");
ylabel("x(t)");
title("Sinal contínuo: combinação de 3 senoides");
xlim([0 0.01]);   % mostra só os 10 ms iniciais

