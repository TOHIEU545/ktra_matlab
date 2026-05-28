clc; clear;

% a. Tao chuoi bit
Nbit = 10000;
bit = [zeros(1, Nbit / 2), ones(1, Nbit / 2)];
bit = bit(randperm(Nbit));
disp(bit);

% b. 4 QAM
M = 4;
k = log2(M);
SNR = 10;

% Chuyen chuoi bit sang ma tran moi hang k bit
bit_tx_matrix = reshape(bit, k, []).';
% Doi nhom 2 bit sang so thap phan
symbol_tx = bi2de(bit_tx_matrix, 'left-msb');

% Dieu che 4 QAM
tx_signal = qammod(symbol_tx, M, 'UnitAveragePower', true);
% Qua kenh awgn
rx_signal = awgn(tx_signal, SNR, 'measured');

% c. Gina do trom sao
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
title('Chom sao sau khi qua kenh AWGN');

% d. Tinh so bit loi
symbol_rx = qamdemod(rx_signal, M, 'UnitAveragePower', true);
bit_rx_matrix = de2bi(symbol_rx, k, 'left-msb');
bit_rx = reshape(bit_rx_matrix.', 1, []);

% Tinh so bit loi
so_bit_loi = sum(bit ~= bit_rx);
BER = so_bit_loi / Nbit;

disp(['So bit loi: ', num2str(so_bit_loi)]);
disp(['Ti le bit loi BER: ', num2str(BER)]);
