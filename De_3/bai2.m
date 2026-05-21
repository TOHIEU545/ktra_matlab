clc; clear;

% Cau hinh thong so
Rb = 500e6;
Tb = 1 / Rb;

Nbit = 50;
Ns = 1000;           % So mau tren 1 bit
Ts = Tb / Ns;       % Khoang cach giua cac lan lay mau

% a. Tao chuoi bit gom 50 phan tu
bit = randi([0 1], 1, Nbit);
disp('Chuoi bit nhi phan: ');
disp(bit);

% b. Chuyen chuoi bit sang ma duong CMI
x = zeros(1, Nbit * Ns);% Tin hieu CMI
muc_1 = 1;              % Muc ban dau cho bit 1

for k = 1 : Nbit
    % Xac dinh vi tri mau cua bit thu k
    start = (k - 1) * Ns + 1;
    stop = k * Ns;
    mid = start + Ns / 2 - 1;

    if bit(k) == 0
        % Bit 0: nua dau -1, nua sau +1
        x(start:mid) = -1;
        x(mid + 1:stop) = 1;
    else
        % Bit 1: giu nguyen trong ca chu ky bit
        x(start:stop) =  muc_1;
        % Dao dau cho bit 1 tiep theo
        muc_1 = -muc_1;
    end
end

% c. Ve bieu dien dang song tin hieu tren 10 chu ky bit
so_bit_ve = 10;
so_mau_ve = so_bit_ve * Ns;

% Tao truc thoi gian
t = 0:Ts:Ts * (so_mau_ve - 1);

figure;
plot(t * 1e9, x(1:so_mau_ve), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t (ns)');
ylabel('Bien do x(t)');
title('Dang song ma duong CMI tren 10 chu ky bit');
ylim([-1.5 1.5]);
xlim([0 so_bit_ve * Tb * 1e9]);

