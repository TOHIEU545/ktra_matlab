function[x, y] = func_euler(f, x0, y0, h, N)

x = zeros(1, N + 1);
y = zeros(1, N + 1);

x(1) = x0;
y(1) = y0;

for k = 1:N
    x(k + 1) = x(k) + h;
    y(k + 1) = y(k) + h * f(x(k), y(k));
end
end