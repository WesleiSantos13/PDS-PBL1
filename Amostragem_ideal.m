% ==========================================================
% Amostragem ideal de um sinal composto por 3 senóides
% ==========================================================

% ---------- Sinal "quase contínuo" ----------
fs_quase = 50000;        % frequência de amostragem bem alta -> aproxima sinal contínuo
T_final  = 0.01;         % duração do sinal (10 ms)
t_cont   = 0:1/fs_quase:T_final;   % vetor de tempo contínuo (denso)

% Componentes do sinal (senóides)
f1 = 100;    % frequência 1 (Hz)
f2 = 300;    % frequência 2 (Hz)
f3 = 600;    % frequência 3 (Hz)

s1 = sin(2*pi*f1*t_cont);          % senóide 1
s2 = 0.7*sin(2*pi*f2*t_cont);      % senóide 2 (amplitude 0.7)
s3 = 0.5*sin(2*pi*f3*t_cont);      % senóide 3 (amplitude 0.5)

x_cont = s1 + s2 + s3;             % sinal contínuo (soma das senóides)

% ---------- Condições de Nyquist ----------
% fmax = 600 Hz
% fs >= 2*fmax = 1200 Hz -> sem aliasing
% fs = 1200 Hz -> caso crítico
% fs < 1200 Hz -> haverá aliasing

% ---------- Taxas de amostragem para testar ----------
fs_lista = [5000, 1200, 800];   % sem aliasing, crítico, e com aliasing

% ---------- Pré-alocação para salvar resultados ----------
tempo_amostras   = cell(1,numel(fs_lista)); % instantes de amostragem
valores_amostras = cell(1,numel(fs_lista)); % valores das amostras
trem_impulsos    = cell(1,numel(fs_lista)); % trem de impulsos (para espectro)

dt = 1/fs_quase;
N  = length(t_cont);

% ==========================================================
% Loop sobre cada taxa de amostragem escolhida
% ==========================================================
for k = 1:length(fs_lista)
    fs = fs_lista(k);          % frequência de amostragem atual
    Ts = 1/fs;                 % período de amostragem

    % Instantes de amostragem (equiespaçados)
    t_amostras = 0:Ts:T_final;

    % Amostras do sinal (xn[n] = x(t_amostras))
    xn = interp1(t_cont, x_cont, t_amostras, 'linear');

    % Guardar resultados
    tempo_amostras{k}   = t_amostras;
    valores_amostras{k} = xn;

    % Construir trem de impulsos (aproximação no grid t_cont)
    impulsos = zeros(size(t_cont));
    idx = round(t_amostras*fs_quase) + 1;  % índices no vetor contínuo
    impulsos(idx) = xn / dt;               % impulsos proporcionais às amostras
    trem_impulsos{k} = impulsos;

    % ---------- Plotagem no tempo ----------
    figure;
    plot(t_cont, x_cont, 'b', 'LineWidth', 1.2); hold on;
    stem(t_amostras, xn, 'r', 'filled');  % plota amostras
    xlabel('Tempo (s)');
    ylabel('Amplitude');
    title(sprintf('Sinal contínuo e amostras (fs = %d Hz)', fs));
    legend('x(t) contínuo','Amostras xn[n]');
    xlim([0 0.01]); % mostra apenas os 10 ms iniciais
    grid on;
end

