clc; clear;

% Cau hinh tham so 
fs = 1000;
ts = 1 / fs;
T_total = 2;
t = 0:ts:T_total - ts;

% Tin hieu
x = cos(5*pi*t + pi / 2) + 10*cos(50*pi*t - pi / 2);

% a. Mo phong tin hieu trong mien thoi gian
figure;
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Mo phong tin hieu trong mien thoi gian');
xlim([0 T_total]);

% b. Bien doi Fourier
N = length(x);
df = fs / N;

x_fft = fft(x);
x_fft_shift = fftshift(x_fft);

pho_bien_do_2_phia = abs(x_fft_shift) / N;
f_2_phia = -fs/2:df:fs/2 - df;

% c. Ve tin hieu trong mien tan so
figure;
stem(f_2_phia, pho_bien_do_2_phia, 'LineWidth', 1.5)
grid on;
xlabel('Tan so f(Hz)');
ylabel('Pho bien do');
title('Mo phong tin hieu trong mien tan so');
xlim([-50 50]);