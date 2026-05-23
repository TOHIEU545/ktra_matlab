clc; clear;

% a.
Nbit = 5000;
bit = [zeros(1, Nbit / 2), ones(1, Nbit / 2)];
bit = bit(randperm(Nbit));
disp(bit);

% b.
M = 16;
k = log2(M);
SNR = 5;

% Chuyen chuoi bit thanh ma tran, moi hang gom 4 bit
bit_matrix = reshape(bit, k, []).';
% Doi nhom 4 bit sang so thap phan tu 0 den 15
symbol = bi2de(bit_matrix, 'left-msb');

% Dieu che 16-PSK
tx_signal = pskmod(symbol, M, pi/M);

% Truyen qua kenh AWGN
rx_signal = awgn(tx_signal, SNR, 'measured');

% c. Ve
figure;
subplot(2, 1, 1);
plot(real(tx_signal), imag(tx_signal), 'o');
grid on;
axis square;
xlabel('In-phase');
ylabel('Quadrature');
title('Chom sao truoc kenh AWGN');

subplot(2, 1, 2);
plot(real(rx_signal), imag(rx_signal), 'o');
grid on;
axis square;
xlabel('In-phase');
ylabel('Quadrature');
title('Chom sao sau kenh AWGN');

% d.
symbol_rx = pskdemod(rx_signal, M, pi/M);
bit_rx_matrix = de2bi(symbol_rx, k, 'left-msb');
bit_rx = reshape(bit_rx_matrix.', 1, []);
% Tinh so bit loi
so_bit_loi = sum(bit ~= bit_rx);
% Tinh ty le loi bit
BER = so_bit_loi / Nbit;
disp(['So bit loi = ', num2str(so_bit_loi)]);
disp(['Ty le loi bit BER = ', num2str(BER)]);