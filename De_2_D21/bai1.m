clc; clear;

fs = 10000;
ts = 1 / fs;
F = 4;
T = 1 / F;
t = 0 : ts : (10 * T) - ts;

x = sin(8*pi*t);

% a.
fc = 1200;
Ac = 1;
phic = pi / 2;
m = 0.5;

xc = Ac * cos(2*fc*pi*t + phic);
Am = max(abs(x));
x_norm = x / Am;

y = (1 + m*x_norm) .* xc;

% b.
figure;

subplot(3, 1, 1);
plot(t, x, 'LineWidth', 1.5);
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Tin hieu ban tin');
xlim([0 10 * T]);

subplot(3, 1, 2);
plot(t, xc, 'LineWidth', 1.5);
xlabel('Thoi gian t(s)');
ylabel('Bien do song mang xc(t)');
title('Tin hieu song mang');
xlim([0 10 * T]);

subplot(3, 1, 3);
plot(t, y, 'LineWidth', 1.5);
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu sau dieu che x(t)');
title('Tin hieu sau dieu che');
xlim([0 10 * T]);