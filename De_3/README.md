# README - Bài tập MATLAB

File này tóm tắt các kiến thức chính cần chú ý trong 3 câu MATLAB: biến đổi Fourier, mã đường CMI và điều chế pha PM qua kênh AWGN.

---

## Câu 1 - Tín hiệu và biến đổi Fourier

### Mục tiêu

Mô phỏng tín hiệu trong miền thời gian và phân tích phổ tần số bằng FFT.

### Tín hiệu sử dụng

```matlab
x = cos(40*pi*t - pi) + 3*cos(30*pi*t);
```

### Thông số cần chú ý

- `fs = 1000`: tần số lấy mẫu.
- `Ts = 1/fs`: chu kỳ lấy mẫu.
- `T = 1`: thời gian mô phỏng.
- `t = 0:Ts:T-Ts`: trục thời gian.
- `N = length(x)`: số mẫu tín hiệu.

### Biến đổi Fourier

```matlab
X = fft(x);
X_shift = fftshift(X);
f = (-N/2:N/2-1) * (fs/N);
bien_do = abs(X_shift) / N;
```

### Kiến thức cần nhớ

- `fft` dùng để chuyển tín hiệu từ miền thời gian sang miền tần số.
- `fftshift` dùng để đưa tần số 0 về giữa phổ.
- `abs(X_shift)/N` dùng để lấy biên độ phổ đã chuẩn hóa.
- Tín hiệu có hai thành phần tần số chính là `15 Hz` và `20 Hz`.
- Vì tín hiệu là tín hiệu thực nên phổ xuất hiện đối xứng tại `±15 Hz` và `±20 Hz`.

### Hàm cần nhớ

```matlab
plot
fft
fftshift
length
abs
grid on
xlabel
ylabel
title
xlim
```

---

## Câu 2 - Mã đường CMI

### Mục tiêu

Tạo chuỗi bit nhị phân gồm 50 phần tử, mã hóa sang mã đường CMI và vẽ dạng sóng trong 10 chu kỳ bit đầu.

### Thông số cần chú ý

- `Rb = 500e6`: tốc độ bit.
- `Tb = 1/Rb`: chu kỳ bit.
- `Nbit = 50`: số bit.
- `Ns = 1000`: số mẫu trên 1 bit.
- `Ts = Tb/Ns`: khoảng cách giữa hai lần lấy mẫu.
- `bit`: chuỗi bit nhị phân.
- `x`: tín hiệu CMI.

Với `Rb = 500e6`:

```text
Tb = 1/Rb = 2e-9 s = 2 ns
```

### Quy tắc mã CMI

```text
Bit 0:
    Nửa đầu chu kỳ bit  -> -1
    Nửa sau chu kỳ bit  -> +1

Bit 1:
    Giữ nguyên mức trong cả chu kỳ bit
    Các bit 1 đảo dấu luân phiên +1, -1, +1, -1,...
```

### Đoạn code quan trọng

Tạo chuỗi bit:

```matlab
bit = randi([0 1], 1, Nbit);
```

Mã hóa bit 0:

```matlab
x(start:mid) = -1;
x(mid + 1:stop) = 1;
```

Mã hóa bit 1:

```matlab
x(start:stop) = muc_1;
muc_1 = -muc_1;
```

Khi vẽ đổi thời gian sang nano giây:

```matlab
t * 1e9
```

### Hàm cần nhớ

```matlab
randi
zeros
for
if else
disp
plot
grid on
xlabel
ylabel
title
ylim
xlim
```

---

## Câu 3 - Điều chế pha PM, kênh AWGN và giải điều chế

### Mục tiêu

Điều chế pha tín hiệu bản tin, truyền qua kênh AWGN, giải điều chế và vẽ kết quả.

### Tín hiệu bản tin

```matlab
x = cos(40*pi*t - pi) + 3*cos(30*pi*t);
```

### Thông số cần chú ý

- `Fs = 200000`: tần số lấy mẫu.
- `fc = 10000`: tần số sóng mang.
- `phic = 0`: pha ban đầu của sóng mang.
- `beta = 0.5`: chỉ số điều chế pha.
- `Pn = 2`: công suất nhiễu.
- `y`: tín hiệu sau điều chế PM.
- `y_noise`: tín hiệu sau khi qua kênh AWGN.
- `x_rec`: tín hiệu sau giải điều chế.

### Điều chế pha PM

```matlab
y = pmmod(x, fc, Fs, beta, phic);
```

Ý nghĩa: pha của sóng mang thay đổi theo biên độ tín hiệu bản tin.

### Kênh AWGN

Tạo nhiễu Gauss trắng:

```matlab
nhieu = sqrt(Pn) * randn(size(y));
```

Cộng nhiễu vào tín hiệu:

```matlab
y_noise = y + nhieu;
```

### Giải điều chế PM

```matlab
x_rec = pmdemod(y_noise, fc, Fs, beta, phic);
```

Làm mượt tín hiệu sau giải điều chế:

```matlab
x_rec = movmean(x_rec, 1000);
```

### Hàm cần nhớ

```matlab
pmmod
pmdemod
randn
sqrt
size
movmean
subplot
plot
grid on
xlabel
ylabel
title
xlim
```

---

## Tổng hợp hàm MATLAB quan trọng

| Hàm | Công dụng |
|---|---|
| `plot` | Vẽ đồ thị tín hiệu |
| `subplot` | Chia cửa sổ hình thành nhiều đồ thị |
| `fft` | Biến đổi Fourier nhanh |
| `fftshift` | Dịch phổ về giữa trục tần số |
| `abs` | Lấy biên độ phổ |
| `length` | Lấy số mẫu tín hiệu |
| `randi` | Tạo chuỗi bit ngẫu nhiên |
| `zeros` | Tạo mảng toàn số 0 |
| `randn` | Tạo nhiễu Gauss trắng |
| `sqrt` | Tính căn bậc hai |
| `size` | Lấy kích thước mảng |
| `pmmod` | Điều chế pha PM |
| `pmdemod` | Giải điều chế pha PM |
| `movmean` | Làm mượt tín hiệu |
| `grid on` | Bật lưới đồ thị |
| `xlabel`, `ylabel`, `title` | Ghi nhãn trục và tiêu đề |

---

## Ghi chú chung

- Nên dùng `clc; clear; close all;` ở đầu chương trình.
- Khi phân tích phổ nên dùng `fftshift` để phổ đối xứng quanh tần số 0.
- Khi vẽ tín hiệu tốc độ cao nên đổi trục thời gian sang nano giây bằng `t*1e9`.
- Với mã CMI, cần nhớ rõ quy tắc mã hóa bit 0 và bit 1.
- Với PM, quá trình chính gồm: điều chế, cộng nhiễu AWGN, giải điều chế.