clc; clear; close all;

% Cau hinh thong so
fs = 1000;           % Tan so lay mau
Ts = 1 / fs;         % Chu ky lay mau
T = 1;               % Thoi gian mo phong
t = 0:Ts:T-Ts;       % Truc thoi gian

% Tin hieu tuong tu
x = cos(40*pi*t - pi) + 3*cos(30*pi*t);

% a. Mo phong va ve bieu dien tin hieu trong mien thoi gian
figure;
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do x(t)');
title('Bieu dien tin hieu x(t) trong mien thoi gian');

% b. Thuc hien bien doi Fourier
N = length(x);           % So mau tin hieu
X = fft(x);              % Bien doi Fourier nhanh FFT
X_shift = fftshift(X);   % Dua thanh phan tan so 0 ve giua pho

% Tao truc tan so
f = (-N/2:N/2-1) * (fs / N);

% Chuan hoa bien do pho
bien_do = abs(X_shift) / N;

% c. Ve bieu dien tin hieu trong mien tan so
figure;
plot(f, bien_do, 'LineWidth', 1.5);
grid on;
xlabel('Tan so f (Hz)');
ylabel('|X(f)|');
title('Bieu dien tin hieu x(t) trong mien tan so');
xlim([-50 50]);