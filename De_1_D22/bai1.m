clc; clear;

% Thiet lap cac thong so
fs = 1000;      % Tan so lay mau
ts = 1 / fs;    % Chu ky lay mau
T_total = 1;    % Tong thoi gian lay mau
t = 0:ts:T_total - ts;
x = cos(20*pi*t + pi / 2) + 2*sin(30*pi*t);

% a. Mo phong tin hieu trong mien thoi gian
figure;
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do tin hieu x(t)');
xlim([0 T_total]);

% b. Bien doi Fourier
N = length(x);      % So dien lay mau (So diem FFT)
df = fs / N;        % Do phan giai tan so (Kc giua 2 vach pho)

x_fft = fft(x);
% Dịch phổ về đối xứng qua gốc 0 [-fs/2 fs/2]
x_fft_shift = fftshift(x_fft);

% Tinh bien do pho
pho_bien_do_2_phia = abs(x_fft_shift) / N;

% Tao truc tan so
f_2_phia = -fs/2:df:fs/2-df;

% c. Ve tin hieu trong mien tan so
figure;
stem(f_2_phia, pho_bien_do_2_phia, 'LineWidth', 1.5);
grid on;
xlabel('Tan so f(Hz)');
ylabel('|X(f)|');
title('Pho bien do 2 phia');
xlim([-50 50]);
