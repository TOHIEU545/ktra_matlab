clc; clear;

% Cau hinh tham so
fs = 100000;
ts = 1 / fs;
t = 0:ts:1 - ts;

% Tin hieu
x = cos(5*pi*t + pi / 2) + 10*cos(50*pi*t - pi / 2);

% a. Dieu che
Ac = 15;
fc = 10e3;
phic= pi / 4;

y = ammod(x, fc, fs, phic, Ac);

% b. Qua kenh AWGN
Pn = 3;
noise = sqrt(Pn) * randn(size(y));
y_noise = y + noise;

% c. Giai dieu che tin hieu
x_rec = amdemod(y_noise, fc, fs, phic, Ac);

% Lam muot tin hieu
x_rec = movmean(x_rec, 1000);

% d. Ve dang song tin hieu
figure;
subplot(3, 1, 1);
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Tin hieu ban tin');

subplot(3, 1, 2);
plot(t, y, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do y(t)');
title('Tin hieu dieu che');

subplot(3, 1, 3);
plot(t, x_rec, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Tin hieu sau giai dieu che');