clc; clear;

% a.
Nbit = 10000;
bit = [zeros(1, Nbit / 2), ones(1, Nbit / 2)];
bit = bit(randperm(Nbit));
disp(bit);

% b.
M = 4;
k = log2(M);
SNR = 10;

% chuyen chuoi bi thanh ma tran moi hang k bit
bit_matrix = reshape(bit, k, []).';
symbol = bi2de(bit_matrix, 'left-msb');

% Dieu che 4 QAM
tx_singnal = qammod(symbol, M, 'UnitAveragePower', true);
rx_signal = awgn(tx_singnal, SNR, 'measured');
