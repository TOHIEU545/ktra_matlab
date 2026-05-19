clc; clear; close all;

% Cau hinh thong so lay mau
Fs = 200000;            % Tan so lay mau
T = 1 / Fs;             % Chu ky lay mau
t = 0:T:0.1 - T;

% Tao tin hieu
x = cos(40*pi*t - pi) + 3 * cos(30*pi*t);

% a. Thuc hien dieu che pha tin hieu bang song mang fc = 10KHz
fc = 10000;             % Tan so song mang
phic = 0;               % Pha ban dau cua song mang
beta = 0.5;          % Chi so dieu che pha

% Tin hieu sau dieu che pha
y = pmmod(x, fc, Fs, beta, phic);

% b. Truyen tin hieu sau dieu che qua kenh AWGN
Pn = 2;                             % Cong suat nhieu
nhieu = sqrt(Pn) * randn(size(y));  % Nhieu Gauss trang

y_noise = y + nhieu;                % Tin hieu sau khi qua kenh AWGN

% c. Giai dieu che tin hieu tai phia thu
x_rec = pmdemod(y_noise, fc, Fs, beta, phic);

% Lam muot tin hieu sau giai dieu che de giam nhieu
x_rec = movmean(x_rec, 1000);

% d. Ve dang song tin hieu ban tin, tin hieu dieu che va tin hieu sau giai dieu che
figure;

subplot(3,1,1);
plot(t, x, 'LineWidth', 1.2);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do x(t)');
title('Tin hieu ban tin');
xlim([0 0.1]);

subplot(3,1,2);
plot(t, y, 'LineWidth', 1.2);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do y(t)');
title('Tin hieu sau dieu che pha PM');
xlim([0 0.005]);

subplot(3,1,3);
plot(t, x_rec, 'LineWidth', 1.2);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do x\_rec(t)');
title('Tin hieu sau giai dieu che PM');
xlim([0 0.1]);