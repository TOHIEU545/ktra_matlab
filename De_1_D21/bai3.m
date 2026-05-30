clc; clear;

% a. Tao chuoi bit co do dai 5000 bit phan bo deu
Nbit = 5000;
bit = [zeros(1, Nbit / 2), ones(1, Nbit / 2)];
bit = bit(randperm(Nbit));
disp(bit);

% b. 16 PSK
M = 16;
k = log2(M);
SNR = 5;

% Chuyen chuoi bit thanh ma tran, moi hang gom k bit
bit_matrix_tx = reshape(bit, k, []).';

% Doi nhom 4 bit sang so thap phan tu 0 den 15
symbol_tx = bi2de(bit_matrix_tx, 'left-msb');

% Dieu che 16 PSK
tx_signal = pskmod(symbol_tx, M, pi / M);

% Qua kenh awgn
rx_signal = awgn(tx_signal, SNR, 'measured');

% c. Ve bieu do trom sao 
figure;
% Tin hieu truoc khi di qua kenh truyen
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

% d. Tinh so bit loi
symbol_rx = pskdemod(rx_signal, M, pi / M);

bit_matrix_rx = de2bi(symbol_rx, k, 'left-msb');

bit_rx = reshape(bit_matrix_rx.', 1, []);

% Tinh so bit loi
so_bit_loi = sum(bit ~= bit_rx);
BER = so_bit_loi / Nbit;

disp(['So bit loi: ', num2str(so_bit_loi)]);
disp(['Ti le loi BER: ', num2str(BER)]);
