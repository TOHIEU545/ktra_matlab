clc; clear

% Thiet lap thong so 
fs = 100000;
ts = 1 / fs;
F = 10;
T = 1 / F;
t = 0:ts:10*T - ts;

% Tin hieu ban tin
x = cos(20*pi*t + pi / 2);

% a. Dieu che
Ac = 2;
fc = 1e3;
phic = pi;
m = 0.5;

% Tin hieu song mang
xc = Ac*cos(2*pi*fc*t + phic);

% Chuan hoa tin hieu ban tin
x_norm = x / max(abs(x));

% Dieu che
y = (1 + m*x_norm) .* xc;

% b.
N_mau = round(10*T*fs);

figure;
subplot(3, 1, 1);
plot(t(1:N_mau), x(1:N_mau), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu x(t)');
title('Tin hieu ban tin');

subplot(3, 1, 2);
plot(t(1:N_mau), xc(1:N_mau), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu song mang xc(t)');
title('Tin hieu song mang');

subplot(3, 1, 3);
plot(t(1:N_mau), y(1:N_mau), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu sau dieu che y(t)');
title('Tin hieu sau dieu che');