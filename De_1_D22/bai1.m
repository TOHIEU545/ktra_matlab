clc; clear;

% Thiet lap cac thong so
fs = 1000;      % Tan so lay mau
ts = 1 / fs;    % Chu ky lay mau
t = 0:ts:1 - ts;
x = cos(20*pi*t + pi / 2) + 2*sin(30*pi*t);

% a. Mo phong tin hieu trong mien thoi gian
figure;
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu x(t)');
xlim([0 1]);

% b. Bien doi Fourier
N = length(x);  % So lan lay mau
x_fft = fft(x);

% c. Ve tin hieu trong mien tan so
x_fft_shift = fftshift(x_fft);
pho_bien_do_2_phia = abs(x_fft_shift) / N;
df = fs / N;
f_2_phia = -fs/2:df:fs/2-df;

figure;
stem(f_2_phia, pho_bien_do_2_phia, 'LineWidth', 1.5);
grid on;
xlabel('Tan so f(Hz)');
ylabel('|X(f)|');
title('Pho bien do 2 phia');
xlim([-50 50]);
