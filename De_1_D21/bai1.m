clc; clear;

fs = 200000;
ts = 1 / fs;
F = 10;
T = 1 / F; 
t = 0:ts:10*T - ts;

x = cos(20*pi*t + pi/2);

% a.
fc = 1000;
Ac = 2;
phic = pi;
m = 0.5;

Am = max(abs(x));
x_norm = x / Am;

xc = Ac*cos(2*pi*fc*t + phic);
y = (1 + m*x_norm) .* xc;

% b.
figure;
subplot(3, 1, 1);
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Tin hieu ban tin');
xlim([0 10 * T]);

subplot(3, 1, 2);
plot(t, xc, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do song mang xc(t)');
title('Tin hieu song mang');
xlim([0 10 * T]);

subplot(3, 1, 3);
plot(t, y, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do sau dieu che y(t)');
title('Tin hieu sau dieu che');
xlim([0 10 * T]);