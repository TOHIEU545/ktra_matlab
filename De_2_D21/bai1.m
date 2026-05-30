clc; clear;

% Cau hinh tham so
fs = 100000;
ts = 1 / fs;
F = 4;          % Tan so tin hieu  
T = 1 / F;      % Chu ki tin hieu 
t = 0:ts:10*T -ts;% 10 chu ki tin hieu ban tin

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
figure;
subplot(3, 1, 1);
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do x(t)');
title('Tin hieu ban tin');

subplot(3, 1, 2);
plot(t, xc, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do xc(t)');
title('Tin hieu song mang');

subplot(3, 1, 3);
plot(t, y, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do y(t)');
title('Tin hieu sau dieu che');