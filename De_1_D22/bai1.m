clc; clear; close all;

fs = 1000;  % Tan so lay mau
ts = 1 / fs;
T = 1;
t = 0:ts:T - ts;

x = cos(20 * pi * t + pi / 2) + 2 * sin(30 * pi * t);

% a. Ve tin hieu trong mien thoi gian
figure;
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('t(s)');
ylabel('x(t)');
title('Mo phong tin hieu trong mien thoi gian');
xlim([0 0.3]);

% b. FFT
N = length(x);
x_fft = fft(x);

% Do phan giai tan so
df = fs / N;


% c1. Pho bien do 2 phia, co dung fftshift

x_fft_shift = fftshift(x_fft);

f_2_phia = -fs/2 : df : fs/2 - df;

pho_bien_do_2_phia = abs(x_fft_shift) / N;

figure;
stem(f_2_phia, pho_bien_do_2_phia, 'LineWidth', 1.5);
grid on;
xlabel('Tan so f(Hz)');
ylabel('|X(f)|');
title('Pho bien do 2 phia');
xlim([-50 50]);


% c2. Pho bien do 1 phia, khong dung fftshift

% Lay bien do goc cua FFT
pho_goc = abs(x_fft) / N;

% Lay nua dau cua pho, tu 0 Hz den fs/2
pho_bien_do_1_phia = pho_goc(1:N/2+1);

% Nhan doi cac thanh phan nam giua, tru DC va Nyquist
pho_bien_do_1_phia(2:end-1) = 2 * pho_bien_do_1_phia(2:end-1);

% Tao truc tan so mot phia
f_1_phia = 0 : df : fs/2;

figure;
stem(f_1_phia, pho_bien_do_1_phia, 'LineWidth', 1.5);
grid on;
xlabel('Tan so f(Hz)');
ylabel('|X(f)|');
title('Pho bien do 1 phia');
xlim([0 50]);