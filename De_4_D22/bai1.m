clc; clear;

fs = 1000;
ts = 1 / fs;
t = 0:ts:2-ts;

% a. Mo phong tin hieu trong mien thoi gian
x = cos(5*pi*t + pi/2) + 10*cos(50*pi*t - pi/2);

figure;
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Mo phong tin hieu trong mien thoi gian');

% b. Bien doi fourier
N = length(x);
x_fft = fft(x);

% c. Ve tin hieu trong mien tan so
x_fft_shift = fftshift(x_fft);
pho_bien_do = abs(x_fft_shift) / N;

df = fs / N;
f_2_phia = -fs/2:df:fs/2 - df;

figure;
stem(f_2_phia, pho_bien_do, 'LineWidth', 1.5);
grid on;
xlabel('Tan so f (Hz)');
ylabel('|X(f)|');
title('Pho bien do 2 phia');
xlim([-30 30]);