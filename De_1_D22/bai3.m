clc; clear;

% Cau hinh thong so lay mau
Fs = 200000;
Ts = 1 / Fs;
t = 0 : Ts : 0.1 - Ts;

x = cos(20*pi*t + pi/2) + 2 * sin(30*pi*t);

% a1. Dieu che fc = 1k
fc = 1000;
A = 5;
phic = 0;

y = ammod(x, fc, Fs, 0, A);

% b. Truyen tin hieu sau dieu che qua kenh AWGN voi SNR = 5 dB
SNR = 5;
y_noise = awgn(y, SNR, 'measured');

% c. Giai dieu che tin hieu
x_rec = amdemod(y_noise, fc, Fs, 0, A);

x_rec = movmean(x_rec, 500);

% d. Ve dang song tin hieu
figure;
subplot(3, 1, 1);
plot(t, x, 'LineWidth', 1.5);
xlabel('Thoi gian t (s)');
ylabel('Bien do x(t)');
title('Tin hieu ban tin');
xlim([0 0.1]);

subplot(3, 1, 2);
plot(t, y, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do y(t)');
title('Tin hieu sau dieu che bien do AM');
xlim([0 0.01]);

subplot(3, 1, 3);
plot(t, x_rec, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do x\_rec(t)');
title('Tin hieu sau giai dieu che AM');
xlim([0 0.1]);