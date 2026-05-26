clc; clear;

% a. Tao chuoi bi gom 100 phan tu
Nbit = 100;
bit = randi([0 1], 1, Nbit);
disp('Chuoi bit nhi phan: ');
disp(bit);

% b. Ma duong RZ 25% luong cuc 1Gb/s
Rb = 1e9;
Tb = 1 / Rb;

Ns = 1000;      % So mau tren 1 bit
Ts = Tb / Ns;   % Khoang thoi gian giua cac lan lay mau

x = [];

for k = 1:Nbit
    if bit(k) == 1
        x = [x, ones(1, Ns*0.25), zeros(1, Ns*0.75)];
    else
        x = [x, -1*ones(1, Ns*0.25), zeros(1, Ns*0.75)];
    end
end

% c. Ve bieu dien dang song tren 10 chu ki bit
so_bit_ve = 10;
so_mau_ve = so_bit_ve * Ns;

t = 0:Ts:Ts*so_mau_ve - Ts;

figure;
plot(t * 1e9, x(1:so_mau_ve), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(ns)');
ylabel('Bien do x(t)');
title('Bieu do dang song tin hieu tren 10 chu ki bit');
xlim([0 so_bit_ve * Tb * 1e9]);
ylim([-1.5 1.5]);