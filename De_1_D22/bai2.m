clc; clear;

% a. Tao chuoi bi gom 100 phan tu
Nbit = 100;
bit = randi([0 1], 1, Nbit);
disp('Chuoi bit nhi phan: ');
disp(bit);

% b. Ma duong RZ 25% luong cuc 1Gb/s
Rb = 1e9;       % Toc do bit
Tb = 1 / Rb;    % Chu ki bit

Ns = 1000;      % So mau tren 1 bit
ts = Tb / Ns;   % Chu ki lay mau

x = [];
muc_1 = 1;

for k = 1:Nbit
    if bit(k) == 1
        x = [x, muc_1*ones(1, Ns*0.25), zeros(1, Ns*0.75)];
        muc_1 = -muc_1;
    else
        x = [x, zeros(1, Ns)];
    end
end

% c. Ve bieu dien dang song tren 10 chu ki bit
N_view = 10;
Ns_view = N_view * Ns;      % So mau trong 10 chu ki

t = 0:ts:N_view*Tb - ts;

figure;
plot(t * 1e9, x(1:Ns_view), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(ns)');
ylabel('Bien do x(t)');
title('Bieu do dang song tin hieu tren 10 chu ki bit');
xlim([0 N_view * Tb * 1e9]);
ylim([-1.5 1.5]);