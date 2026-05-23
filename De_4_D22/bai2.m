clc; clear;

Rb = 100e6;
Tb = 1 / Rb;
Nbit = 100;
Ns = 1000;
ts = Tb / Ns;

% a. Tao chuoi bit
bit = randi([0 1], 1, Nbit);
disp('Chuoi bi tao duoc la: ');
disp(bit);

% b. Chuyen doi chuoi bit thanh dang song RZ 75%
x = zeros(1, Ns * Nbit);
duty = 0.75;
Ns_xung = duty * Ns;

for k = 1:Nbit
    start = (k - 1) * Ns + 1;
    stop = k * Ns;
    stop_xung = start + Ns_xung - 1;

    if bit(k) == 1
        x(start:stop_xung) = 1;
        x(stop_xung + 1:stop) = 0;
    else
        x(start:stop) = 0;
    end
end

% c. Ve tin hieu
so_bit_ve = 10;
so_mau_ve = so_bit_ve * Ns;
t = 0:ts:ts * (so_mau_ve - 1);
figure;
plot(t * 1e6, x(1:so_mau_ve), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(us)');
ylabel('Bien do x(t)');
title('Dang song RZ 75% tren 10 chu ki bit');
ylim([-1.5 1.5]);
xlim([0 so_bit_ve * Tb * 1e6]);