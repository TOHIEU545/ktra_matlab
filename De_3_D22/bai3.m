clc; clear; close all;

% Cau hinh thong so
fs = 100000;
ts = 1 / fs;
t = 0:ts:1-ts;

% Tin hieu ban tin
x = cos(40*pi*t - pi) + 3*cos(30*pi*t);

% a. Dieu che pha PM
fc = 10e3;
phasedev = pi/2; % Gia su do lech pha vi de khong cho
phic = 0;

y = pmmod(x, fc, fs, phasedev, phic);

% b. Qua kenh AWGN voi cong suat nhieu Pn = 2
Pn = 2;
noise = sqrt(Pn) * randn(size(y));
y_noise = y + noise;

% c. Giai dieu che PM
x_rec = pmdemod(y_noise, fc, fs, phasedev, phic);

% d. Ve
figure;

subplot(3, 1, 1);
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Tin hieu ban tin');
xlim([0 0.2]);

subplot(3, 1, 2);
plot(t, y, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do y(t)');
title('Tin hieu dieu che pha PM');
xlim([0 0.002]);

subplot(3, 1, 3);
plot(t, x_rec, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x rec(t)');
title('Tin hieu sau khi giai dieu che');
xlim([0 0.2]);