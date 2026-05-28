clc; clear;

% Cac thong so cau hinh
fs = 1000;
ts = 1 / fs;
t = 0:ts:1-ts;

% Tin hieu 
x = cos(40*pi*t - pi) + 3*cos(30*pi*t);

% a. Mo phon va ve tin hieu trong mien thoi gian
figure;
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Mo phong tin hieu trong mien thoi gian');

% b. Bien doi Fourier
N = length(x);
x_fft = fft(x);

% Ve tin hieu trong mien tan so
df = fs / N;
x_fft_shift = fftshift(x_fft);
f_2_phia = -fs/2:df:fs/2 - df;
pho_bien_do_2_phia = abs(x_fft_shift) / N;

figure;
stem(f_2_phia, pho_bien_do_2_phia, 'LineWidth', 1.5);
xlabel('Tan so f(Hz)');
ylabel('Pho bien do');
title('Tin hieu trong mien tan so');
xlim([-50 50]);
