clc; clear;

% a. Tao chuoi bit gom 100 phan tu
Nbit = 100;
bit = randi([0 1], 1, Nbit);
disp(bit);


% b. RZ 75% 
Rb = 100e6;
Tb = 1 / Rb;

Ns = 1000;
ts = Tb / Ns;

x = [];

for k = 1:Nbit
    if bit(k) == 1
        x = [x, ones(1, Ns*0.75), zeros(1, Ns*0.25)];
    else
        x = [x, zeros(1, Ns)];
    end
end

% c. ve 10 chu ki bit
N_view = 10;
Ns_view = N_view * Ns;

t = 0:ts:N_view*Tb - ts;

figure;
plot(t * 1e6, x(1:Ns_view), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian x(us)');
ylabel('Bien do x(t)');
title('Dang song tin hieu trong 10 chu ki bit');
xlim([0 N_view*Tb*1e6]);
ylim([-1.5 1.5]);