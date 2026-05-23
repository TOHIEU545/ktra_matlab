clc; clear;

fs = 200000;
ts = 1 / fs;
t = 0:ts:0.1-ts;

x = cos(5*pi*t + pi/2) + 10*cos(50*pi*t - pi/2);

% a. Dieu che bien tin hieu
fc = 10000;
A = 20;
phic = pi/4;

y = ammod(x, fc, fs, phic, A);

% b.
Pn = 3;
nhieu = sqrt(Pn) * randn(size(y));
y_noise = y + nhieu;

% c. Giai dieu che
x_rec = amdemod(y_noise, fc, fs, phic, A);
x_rec = movmean(x_rec, 500);

% d. Ve tin hieu
figure;
subplot(3, 1, 1);
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Dang song tin hieu ban tin');
xlim([0 0.1]);

subplot(3, 1, 2);
plot(t, y_noise, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do y(t)');
title('Tin hieu sau dieu che');
xlim([0 0.005]);

subplot(3, 1, 3);
plot(t, x_rec, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x_rec');
title('Tin hieu sau giai dieu che');
xlim([0 0.1]);