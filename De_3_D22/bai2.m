clc; clear;

% a. Tao chuoi bit
Nbit = 50;
bit = randi([0 1], 1, Nbit);
disp(bit);

% b. CMI 
Rb = 500e6;
Tb = 1 / Rb;

Ns = 1000;
ts = Tb / Ns;

x = [];
muc_1 = 1;

for k = 1:Nbit
    if bit(k) == 0
        x = [x, -1*ones(1, Ns/2), 1*ones(1, Ns/2)];
    else
        x = [x, muc_1*ones(1, Ns)];
        muc_1 = -muc_1;
    end
end

% c. Ve dang song tin hieu trong 10 chu ki bit
so_bit_ve = 10;
so_mau_ve = so_bit_ve * Ns;
t = 0:ts:ts*so_mau_ve - ts;

figure;
plot(t * 1e9, x(1:so_mau_ve), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(ns)');
ylabel('Bien do x(t)');
title('Bieu do dang song tin hieu tren 10 chu ki bit');
xlim([0 so_bit_ve*Tb*1e9]);
ylim([-1.5 1.5]);