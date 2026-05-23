clc; clear;

Rb = 1e9;
Tb = 1 / Rb;    % Chu ki bit

Nbit = 100;
Ns = 1000;      % So mau tren 1 bit
Ts = Tb / Ns;   % Khoang tgian giua cac lan lay mau trong 1 bit

% a. Tao chuoi bit gom 100 phan tu
bit = randi([0, 1], 1, Nbit);
disp('Chuoi bit nhi phan: ');
disp(bit);

% b. Chuyen chuoi bit sang ma duong luong cuc RZ 25%
x = zeros(1, Nbit * Ns);
duty = 0.25;    % 25%
Ns_xung = duty * Ns;

for k = 1 : Nbit
    % Xac dinh vi tri mau cua bit thu k
    start = (k - 1) * Ns + 1;
    stop = k * Ns;
    stop_xung = start + Ns_xung - 1;

    if bit(k) == 1
        x(start : stop_xung) = 1;
        x(stop_xung + 1 : stop) = 0;
    else
        x(start : stop_xung) = -1;
        x(stop_xung + 1 : stop) = 0;
    end
end

%c. Ve tin hieu trong 10 chu ki bit

so_bit_ve = 10;
so_mau_ve = so_bit_ve * Ns;

t = 0 : Ts : Ts * (so_mau_ve  - 1);

figure;
plot(t * 1e9, x(1 : so_mau_ve), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t (ns)');
ylabel('Bien do x(t)');
title('Dang song ma duong CMI tren 10 chu ky bit');
ylim([-1.5 1.5]);
xlim([0 so_bit_ve * Tb * 1e9]);