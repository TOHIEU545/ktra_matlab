# README - Ghi chú kiến thức và công thức MATLAB

Tài liệu này tổng hợp các kiến thức, công thức và ý nghĩa các bước dùng trong 3 file MATLAB:

- `bai1(6).m`: mô phỏng tín hiệu tương tự và biến đổi Fourier.
- `bai2(6).m`: tạo chuỗi bit và mã đường RZ 25% lưỡng cực.
- `bai3(5).m`: điều chế AM, truyền qua kênh AWGN và giải điều chế.

---

## 1. File `bai1(6).m` - Tín hiệu tương tự và phổ Fourier

### 1.1. Tín hiệu ban đầu

Tín hiệu được xét:

```math
x(t) = \cos\left(20\pi t + \frac{\pi}{2}\right) + 2\sin(30\pi t)
```

Trong đó:

```math
\omega = 2\pi f
```

Suy ra:

```math
20\pi = 2\pi f_1 \Rightarrow f_1 = 10\text{ Hz}
```

```math
30\pi = 2\pi f_2 \Rightarrow f_2 = 15\text{ Hz}
```

Vậy tín hiệu gồm 2 thành phần tần số chính:

- Thành phần cos có tần số `10 Hz`.
- Thành phần sin có tần số `15 Hz`.

### 1.2. Lấy mẫu tín hiệu

Trong MATLAB:

```matlab
fs = 1000;
ts = 1 / fs;
t = 0:ts:1-ts;
```

Ý nghĩa:

```math
T_s = \frac{1}{f_s}
```

Trong đó:

- `fs`: tần số lấy mẫu.
- `ts`: chu kỳ lấy mẫu.
- `t`: vector thời gian.

Với `fs = 1000 Hz`, mỗi giây có 1000 mẫu.

### 1.3. Biến đổi Fourier rời rạc bằng FFT

Trong MATLAB:

```matlab
x_fft = fft(x);
```

Lệnh `fft` dùng để chuyển tín hiệu từ miền thời gian sang miền tần số.

Công thức DFT:

```math
X[k] = \sum_{n=0}^{N-1} x[n]e^{-j2\pi kn/N}
```

Trong đó:

- `x[n]`: tín hiệu rời rạc trong miền thời gian.
- `X[k]`: tín hiệu trong miền tần số.
- `N`: số mẫu của tín hiệu.

### 1.4. Chuẩn hóa phổ biên độ

Trong MATLAB:

```matlab
pho_bien_do_2_phia = abs(x_fft_shift) / N;
```

Ý nghĩa:

```math
|X(f)| = \frac{|FFT(x)|}{N}
```

Chia cho `N` để chuẩn hóa biên độ phổ.

### 1.5. Dùng `fftshift`

Trong MATLAB:

```matlab
x_fft_shift = fftshift(x_fft);
```

Lệnh `fftshift` đưa phổ về dạng 2 phía, trục tần số nằm trong khoảng:

```math
-\frac{f_s}{2} \le f < \frac{f_s}{2}
```

Vector tần số:

```matlab
df = fs / N;
f_2_phia = -fs/2:df:fs/2-df;
```

Trong đó:

```math
\Delta f = \frac{f_s}{N}
```

---

## 2. File `bai2(6).m` - Mã đường RZ 25% lưỡng cực

### 2.1. Tạo chuỗi bit nhị phân

Trong MATLAB:

```matlab
Nbit = 100;
bit = randi([0 1], 1, Nbit);
```

Ý nghĩa:

- `Nbit = 100`: tạo chuỗi gồm 100 bit.
- `randi([0 1], 1, Nbit)`: sinh ngẫu nhiên các bit 0 hoặc 1.

### 2.2. Tốc độ bit và chu kỳ bit

Trong MATLAB:

```matlab
Rb = 1e9;
Tb = 1 / Rb;
```

Công thức:

```math
T_b = \frac{1}{R_b}
```

Với:

```math
R_b = 1\text{ Gbps} = 10^9\text{ bit/s}
```

Suy ra:

```math
T_b = 10^{-9}\text{ s} = 1\text{ ns}
```

### 2.3. Số mẫu trên mỗi bit

Trong MATLAB:

```matlab
Ns = 1000;
Ts = Tb / Ns;
```

Ý nghĩa:

- `Ns`: số mẫu dùng để biểu diễn 1 bit.
- `Ts`: khoảng thời gian giữa 2 mẫu liên tiếp.

Công thức:

```math
T_s = \frac{T_b}{N_s}
```

### 2.4. Mã đường RZ 25%

RZ là viết tắt của `Return to Zero`, nghĩa là tín hiệu có xung rồi trở về 0 trong cùng một chu kỳ bit.

RZ 25% nghĩa là xung chỉ tồn tại trong 25% thời gian bit:

```math
T_{xung} = 0.25T_b
```

Phần còn lại trở về 0:

```math
T_0 = 0.75T_b
```

Trong code:

```matlab
ones(1, Ns*0.25), zeros(1, Ns*0.75)
```

nghĩa là:

- 25% số mẫu đầu có biên độ khác 0.
- 75% số mẫu sau có biên độ 0.

### 2.5. Mã RZ 25% lưỡng cực

Lưỡng cực nghĩa là tín hiệu có cả mức dương và mức âm:

```math
bit\ 1 \Rightarrow +1\ trong\ 25\%T_b,\ sau\ đó\ về\ 0
```

```math
bit\ 0 \Rightarrow -1\ trong\ 25\%T_b,\ sau\ đó\ về\ 0
```

Cách mã hóa:

```matlab
if bit(k) == 1
    x = [x, ones(1, Ns*0.25), zeros(1, Ns*0.75)];
else
    x = [x, -1*ones(1, Ns*0.25), zeros(1, Ns*0.75)];
end
```

Nên viết chắc hơn bằng cách dùng số mẫu nguyên:

```matlab
Np = round(Ns * 0.25);
Nz = Ns - Np;
```

Sau đó:

```matlab
if bit(k) == 1
    x = [x, ones(1, Np), zeros(1, Nz)];
else
    x = [x, -ones(1, Np), zeros(1, Nz)];
end
```

---

## 3. File `bai3(5).m` - Điều chế AM, kênh AWGN và giải điều chế

### 3.1. Tín hiệu bản tin

Tín hiệu bản tin trong file:

```math
x(t) = \cos\left(20\pi t - \frac{\pi}{2}\right) + 2\sin(30\pi t)
```

Tương tự bài 1, tín hiệu gồm hai thành phần chính:

- Thành phần tần số `10 Hz`.
- Thành phần tần số `15 Hz`.

### 3.2. Sóng mang

Trong MATLAB:

```matlab
xc = Ac*cos(2*pi*fc*t + phic);
```

Công thức:

```math
x_c(t) = A_c\cos(2\pi f_c t + \varphi_c)
```

Trong đó:

- `Ac`: biên độ sóng mang.
- `fc`: tần số sóng mang.
- `phic`: pha ban đầu của sóng mang.

Trong bài:

```math
f_c = 1\text{ kHz} = 1000\text{ Hz}
```

### 3.3. Chuẩn hóa tín hiệu bản tin

Trong MATLAB:

```matlab
x_norm = x / max(abs(x));
```

Ý nghĩa:

```math
x_{norm}(t) = \frac{x(t)}{\max|x(t)|}
```

Mục đích:

- Đưa biên độ tín hiệu bản tin về khoảng gần `[-1, 1]`.
- Giúp tránh quá điều chế khi thực hiện AM.

### 3.4. Điều chế biên độ AM

Trong MATLAB:

```matlab
y = (1 + m*x_norm) .* xc;
```

Công thức:

```math
y(t) = A_c[1 + m x_{norm}(t)]\cos(2\pi f_c t + \varphi_c)
```

Trong đó:

- `m`: hệ số điều chế.
- `x_norm(t)`: tín hiệu bản tin đã chuẩn hóa.
- `xc`: sóng mang.

Điều kiện để tránh quá điều chế:

```math
0 \le m \le 1
```

Nếu `m > 1`, tín hiệu có thể bị méo do quá điều chế.

### 3.5. Công suất tín hiệu

Trong MATLAB:

```matlab
Ps = mean(y.^2);
```

Công thức công suất trung bình:

```math
P_s = \frac{1}{N}\sum_{n=1}^{N} y^2[n]
```

### 3.6. SNR và đổi từ dB sang dạng thường

Trong MATLAB:

```matlab
SNR_dB = 5;
SNR = 10^(SNR_dB/10);
```

Công thức:

```math
SNR_{dB} = 10\log_{10}(SNR)
```

Suy ra:

```math
SNR = 10^{SNR_{dB}/10}
```

Với `SNR_dB = 5 dB`:

```math
SNR = 10^{5/10}
```

### 3.7. Công suất nhiễu AWGN

Trong MATLAB:

```matlab
Pn = Ps / SNR;
```

Công thức:

```math
SNR = \frac{P_s}{P_n}
```

Suy ra:

```math
P_n = \frac{P_s}{SNR}
```

### 3.8. Tạo nhiễu Gauss trắng AWGN

Trong MATLAB:

```matlab
noise = sqrt(Pn) * randn(size(y));
r = y + noise;
```

Ý nghĩa:

- `randn(size(y))`: tạo nhiễu Gauss có trung bình 0, phương sai 1.
- `sqrt(Pn)`: chỉnh biên độ nhiễu để công suất nhiễu bằng `Pn`.
- `r`: tín hiệu thu sau khi qua kênh AWGN.

Công thức:

```math
r(t) = y(t) + n(t)
```

Trong đó:

```math
n(t) \sim \mathcal{N}(0, P_n)
```

### 3.9. Giải điều chế AM đồng bộ

Trong MATLAB:

```matlab
v = 2*r.*cos(2*pi*fc*t + phic);
```

Bên thu nhân tín hiệu nhận được với sóng mang cùng tần số và cùng pha.

Do:

```math
\cos^2(\omega_c t) = \frac{1 + \cos(2\omega_c t)}{2}
```

nên khi nhân lại với sóng mang, tín hiệu xuất hiện hệ số `1/2`. Vì vậy nhân thêm `2` để bù hệ số này.

Sau khi nhân:

```math
v(t) \approx A_c[1 + m x_{norm}(t)] + \text{thành phần cao tần}
```

### 3.10. Lọc thông thấp bằng trung bình trượt

Trong MATLAB:

```matlab
L = round(fs/fc);
h = ones(1, L) / L;
z = conv(v, h, 'same');
```

Trong đó:

```math
L = \frac{f_s}{f_c}
```

`L` là số mẫu trong một chu kỳ sóng mang.

Bộ lọc trung bình trượt:

```math
h[n] = \frac{1}{L},\quad n = 0,1,...,L-1
```

Tác dụng:

- Loại bớt thành phần cao tần sau khi nhân giải điều chế.
- Làm mượt tín hiệu.
- Giảm nhiễu.

Lệnh:

```matlab
conv(v, h, 'same')
```

thực hiện tích chập và giữ kết quả có cùng độ dài với tín hiệu ban đầu.

### 3.11. Loại bỏ DC và khôi phục tín hiệu bản tin

Sau lọc thông thấp, ta có gần đúng:

```math
z(t) \approx A_c[1 + m x_{norm}(t)]
```

Khai triển:

```math
z(t) \approx A_c + A_c m x_{norm}(t)
```

Muốn lấy lại `x_norm(t)`:

```math
x_{rec,norm}(t) = \frac{z(t) - A_c}{A_c m}
```

Trong MATLAB:

```matlab
x_rec_norm = (z - Ac) / (Ac * m);
```

Do tín hiệu ban đầu đã chuẩn hóa bằng:

```math
x_{norm}(t) = \frac{x(t)}{\max|x(t)|}
```

nên cần nhân lại để khôi phục biên độ gần ban đầu:

```math
x_{rec}(t) = x_{rec,norm}(t)\max|x(t)|
```

Trong MATLAB:

```matlab
x_rec = x_rec_norm * max(abs(x));
```

---

## 4. Các lệnh MATLAB quan trọng cần nhớ

### 4.1. Lệnh tạo vector thời gian

```matlab
t = 0:ts:1-ts;
```

Tạo vector thời gian từ `0` đến gần `1 s` với bước `ts`.

### 4.2. Lệnh vẽ tín hiệu

```matlab
plot(t, x, 'LineWidth', 1.5);
grid on;
xlabel('Thoi gian t(s)');
ylabel('Bien do');
title('Ten hinh');
```

### 4.3. Lệnh vẽ nhiều hình trong cùng một figure

```matlab
subplot(3,1,1);
subplot(3,1,2);
subplot(3,1,3);
```

`subplot(3,1,1)` nghĩa là chia figure thành 3 hàng, 1 cột, chọn ô thứ nhất.

### 4.4. Nhân từng phần tử

Trong MATLAB, khi nhân hai vector cùng kích thước, dùng:

```matlab
.*
```

Ví dụ:

```matlab
y = (1 + m*x_norm) .* xc;
```

Không dùng `*` vì `*` là nhân ma trận.

### 4.5. Bình phương từng phần tử

```matlab
y.^2
```

Dấu `.^` dùng để bình phương từng phần tử trong vector.

### 4.6. Tạo nhiễu Gauss

```matlab
randn(size(y))
```

Tạo vector nhiễu Gauss có cùng kích thước với `y`.

### 4.7. Tích chập

```matlab
z = conv(v, h, 'same');
```

Dùng để lọc tín hiệu qua đáp ứng xung `h`.

---

## 5. Tóm tắt công thức chính

### Tần số góc

```math
\omega = 2\pi f
```

### Chu kỳ lấy mẫu

```math
T_s = \frac{1}{f_s}
```

### Chu kỳ bit

```math
T_b = \frac{1}{R_b}
```

### Độ phân giải tần số FFT

```math
\Delta f = \frac{f_s}{N}
```

### Điều chế AM

```math
y(t) = A_c[1 + m x_{norm}(t)]\cos(2\pi f_c t + \varphi_c)
```

### SNR dạng dB

```math
SNR_{dB} = 10\log_{10}\left(\frac{P_s}{P_n}\right)
```

### Đổi SNR dB sang dạng thường

```math
SNR = 10^{SNR_{dB}/10}
```

### Công suất nhiễu

```math
P_n = \frac{P_s}{SNR}
```

### Kênh AWGN

```math
r(t) = y(t) + n(t)
```

### Giải điều chế đồng bộ

```math
v(t) = 2r(t)\cos(2\pi f_c t + \varphi_c)
```

### Công thức nhân cos

```math
\cos^2(\omega t) = \frac{1 + \cos(2\omega t)}{2}
```

### Khôi phục tín hiệu sau giải điều chế AM

```math
x_{rec,norm}(t) = \frac{z(t) - A_c}{A_c m}
```

```math
x_{rec}(t) = x_{rec,norm}(t)\max|x(t)|
```

---

## 6. Ghi chú lỗi dễ gặp

1. Khi nhân hai vector tín hiệu, phải dùng `.*`, không dùng `*`.
2. Khi bình phương từng phần tử, dùng `.^2`, không dùng `^2`.
3. Khi dùng RZ 25%, số mẫu xung nên là số nguyên, nên dùng `round`.
4. Khi vẽ tín hiệu điều chế có tần số sóng mang cao, nên giới hạn trục thời gian nhỏ, ví dụ `xlim([0 0.02])`.
5. Khi giải điều chế đồng bộ, sóng mang phía thu phải cùng tần số và cùng pha với sóng mang phía phát.
6. Nếu `m > 1`, AM có thể bị quá điều chế và tín hiệu sau giải điều chế sẽ bị méo.
7. Với AWGN, SNR càng thấp thì nhiễu càng mạnh và tín hiệu khôi phục càng xấu.
