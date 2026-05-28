clc; clear;

% Cau hinh tham so
fs = 100000;
ts = 1 / fs;
F = 4;
T = 1 / F;
t = 0:ts:10*T -ts;

% Tin hieu ban tin
x = sin(8*pi*t);

% a. Dieu che
Ac = 1;
fc = 1200;
phic = pi / 2;
m = 0.5;

% Tin hieu song mang
xc = Ac*cos(2*pi*fc*t + phic);

% Chuan hoa bien bo
x_norm = x / max(abs(x));

% Dieu che
y = (1 + m*x_norm) .* xc;

% b. Ve tin hieu
so_mau_ve = round(10*T*fs);

figure;
subplot(3, 1, 1);
plot(t(1:so_mau_ve), x(1:so_mau_ve), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Tin hieu ban tin');

subplot(3, 1, 2);
plot(t(1:so_mau_ve), xc(1:so_mau_ve), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do xc(t)');
title('Tin hieu song mang');

subplot(3, 1, 3);
plot(t(1:so_mau_ve), y(1:so_mau_ve), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do y(t)');
title('Tin hieu sau dieu che');
