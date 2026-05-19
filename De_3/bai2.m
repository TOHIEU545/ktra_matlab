clc; clear;

% a. Tao chuoi bit nhi phan gom 50 phan tu
Nbit = 50;
bit = randi([0 1], 1, Nbit);

disp('Chuoi bi nhi phan la: ');
disp(bit);

% Thong so lay mau
Rb = 500e6;
Tb = 1 / Rb;

Ns = 1000;          % So mau tren 1 bit
Ts = Tb / Ns;       % Thoi gi