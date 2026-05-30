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
N_view = 10;
Ns_view = N_view * Ns;

t = 0:ts:N_view*Tb - ts;

figure;
plot(t * 1e6, x(1:Ns_view), 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(us)');
ylabel('Bien do x(t)');
title('Bieu do dang song tin hieu tren 10 chu ki bit');
xlim([0 N_view * Tb * 1e6]);
ylim([-1.5 1.5]);