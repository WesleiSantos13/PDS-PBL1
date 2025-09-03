% ==========================================================
% Amostragem e reconstrução com filtro passa-baixa
% ==========================================================

% ---------- Sinal "quase contínuo" ----------
fs_quase = 50000;        % frequência de amostragem bem alta -> aproxima sinal contínuo
T_final  = 0.01;         % duração do sinal (10 ms)
t_cont   = 0:1/fs_quase:T_final;   % vetor de tempo contínuo (denso)

% Componentes do sinal (senóides)
f1 = 100; f2 = 300; f3 = 600;
s1 = sin(2*pi*f1*t_cont);
s2 = 0.7*sin(2*pi*f2*t_cont);
s3 = 0.5*sin(2*pi*f3*t_cont);
x_cont = s1 + s2 + s3;   % sinal contínuo

% ---------- Frequências de amostragem ----------
fs_lista = [5000, 1200, 800];   % sem aliasing, crítico e com aliasing

% Loop sobre cada taxa de amostragem
for k = 1:length(fs_lista)
    fs = fs_lista(k);
    Ts = 1/fs;

    % Amostragem
    t_amostras = 0:Ts:T_final;
    xn = interp1(t_cont, x_cont, t_amostras, 'linear');

    % Reconstrução com filtro passa-baixa (interp1 -> aproximação LPF)
    % Aqui usamos interp1 como "ideal LPF sinc" simplificado
    x_recon = interp1(t_amostras, xn, t_cont, 'spline', 0);

    % ---------- Plotagem ----------
    figure;
    plot(t_cont, x_cont, 'b', 'LineWidth', 1.2); hold on;
    stem(t_amostras, xn, 'r', 'filled');
    plot(t_cont, x_recon, 'g--', 'LineWidth', 1.2);
    xlabel('Tempo (s)');
    ylabel('Amplitude');
    title(sprintf('Reconstrução no tempo (fs = %d Hz)', fs));
    legend('Sinal original x(t)', 'Amostras xn[n]', 'Reconstruído x_r(t)');
    xlim([0 0.01]);
    grid on;
end

