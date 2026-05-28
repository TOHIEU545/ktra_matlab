clc; clear;

% Thiet lap cac thong so
fs = 100000;
ts = 1 / fs;
t = 0:ts:1 - ts;

x = cos(20*pi*t + pi / 2) + 2*sin(30*pi*t);

% a. Thuc hien dieu che bien do song mang fc = 1khz
Ac = 4;     % Bien do song mang
fc = 1e3;   % Tan so song mang
phic = 0;

% Dieu che
y = ammod(x, fc, fs, phic, Ac);

% b. Truyen tin hieu da dieu che qua kenh AWGN co SNR = 5 dB
SNR = 5;
y_noise = awgn(y, SNR, 'measured');

% c. Thuc hien giai dieu che
% Nhan voi song mang cung tan so, cung pha
x_rec = amdemod(y_noise, fc, fs, phic, Ac);

% d. Ve tin hieu ban tin, tin hieu dieu che va tin hieu sau giai dieu che
figure;

subplot(3, 1, 1);
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do');
title('Tin hieu ban tin x(t)');
xlim([0 0.2]);

subplot(3,1,2);
plot(t, y, 'LineWidth', 1.2);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do');
title('Tin hieu sau dieu che AM');
xlim([0 0.02]);

subplot(3,1,3);
plot(t, x_rec, 'LineWidth', 1.2);
grid on;
xlabel('Thoi gian t (s)');
ylabel('Bien do');
title('Tin hieu sau khi giai dieu che');
xlim([0 0.2]);