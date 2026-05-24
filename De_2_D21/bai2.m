clc; clear

x0 = 0;
y0 = 0;
h = 0.1;
N = 100;

f = @(x, y) x^2 - 2*y;

[x, y] = euler_biendoi(f, x0, y0, h, N);

disp('Ket qua x va y: ');
disp(table(x', y', 'VariableNames', {'x', 'y'}));

figure;
plot(x, y, '-o', 'LineWidth', 1.5);
grid on;
xlabel('x');
ylabel('y');
title('Giai phuong trinh vi phan bang Euler bien doi');