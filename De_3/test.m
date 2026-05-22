clc; clear; close all;

% Cau hinh thong so lay mau
Fs = 1000;              % Tan so lay mau
Ts = 1 / Fs;            % Chu ky lay mau
T = 1;                  % Tong thoi gian lay mau
t = 0:Ts:T-Ts;          % Truc thoi gian

% Tin hieu goc gom 2 tan so 20 Hz va 40 Hz
x = cos(2*pi*20*t) + 0.8*cos(2*pi*40*t);

% Nhieu sin o tan so 30 Hz
nhieu = 0.5*cos(2*pi*30*t);

% Tin hieu sau khi bi nhieu
x_noise = x + nhieu;

% Ve tin hieu trong mien thoi gian
figure;

subplot(2,1,1);
plot(t, x, 'LineWidth', 1.2);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do');
title('Tin hieu goc: 20 Hz va 40 Hz');
xlim([0 0.2]);

subplot(2,1,2);
plot(t, x_noise, 'LineWidth', 1.2);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do');
title('Tin hieu bi nhieu: co them 30 Hz');
xlim([0 0.2]);

% Bien doi Fourier cho tin hieu goc
N = length(x);
X = fft(x);
X_shift = fftshift(X);

% Bien doi Fourier cho tin hieu bi nhieu
Xn = fft(x_noise);
Xn_shift = fftshift(Xn);

% Tao truc tan so
f = (-N/2:N/2-1) * (Fs/N);

% Chuan hoa bien do pho
bien_do_goc = abs(X_shift) / N;
bien_do_nhieu = abs(Xn_shift) / N;

% Ve pho tan so
figure;

subplot(2,1,1);
plot(f, bien_do_goc, 'LineWidth', 1.2);
grid on;
xlabel('Tan so f (Hz)');
ylabel('|X(f)|');
title('Pho tan so cua tin hieu goc');
xlim([0 100]);

subplot(2,1,2);
plot(f, bien_do_nhieu, 'LineWidth', 1.2);
grid on;
xlabel('Tan so f (Hz)');
ylabel('|X(f)|');
title('Pho tan so cua tin hieu bi nhieu');
xlim([0 100]);