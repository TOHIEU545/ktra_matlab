# README - 3 bài MATLAB: FFT, mã CMI và điều chế PM

## Bài 1: Mô phỏng tín hiệu và biến đổi Fourier

### Mục tiêu

- Tạo tín hiệu trong miền thời gian.
- Thực hiện FFT.
- Vẽ phổ biên độ trong miền tần số.

### Tín hiệu

```matlab
x(t) = cos(40*pi*t - pi) + 3*cos(30*pi*t)
```

So sánh với công thức:

```matlab
cos(2*pi*f*t + phi)
```

Suy ra:

```matlab
cos(40*pi*t - pi) -> f = 20 Hz
3*cos(30*pi*t)    -> f = 15 Hz
```

### Lấy mẫu

```matlab
fs = 1000;
Ts = 1/fs;
T = 1;
t = 0:Ts:T-Ts;
```

Ý nghĩa:

```matlab
fs : tần số lấy mẫu
Ts : chu kỳ lấy mẫu
T  : thời gian mô phỏng
```

### FFT

```matlab
N = length(x);
X = fft(x);
X_shift = fftshift(X);
```

Tạo trục tần số:

```matlab
f = (-N/2:N/2-1)*(fs/N);
```

Phổ biên độ:

```matlab
bien_do = abs(X_shift)/N;
```

Công thức cần nhớ:

```matlab
df = fs/N
```

Lưu ý:

```matlab
fftshift dùng để đưa tần số 0 Hz về giữa phổ.
Phổ 2 phía có các vạch tại ±15 Hz và ±20 Hz.
```

---

## Bài 2: Tạo chuỗi bit và mã đường CMI

### Mục tiêu

- Tạo chuỗi bit nhị phân 50 bit.
- Chuyển chuỗi bit sang mã CMI.
- Vẽ dạng sóng trong 10 chu kỳ bit đầu.

### Thông số

```matlab
Rb = 500e6;
Tb = 1/Rb;
Nbit = 50;
Ns = 1000;
Ts = Tb/Ns;
```

Ý nghĩa:

```matlab
Rb   : tốc độ bit
Tb   : chu kỳ bit
Nbit : số bit
Ns   : số mẫu trên 1 bit
Ts   : thời gian giữa 2 mẫu
```

Công thức cần nhớ:

```matlab
Tb = 1/Rb
Ts = Tb/Ns
```

### Tạo chuỗi bit

```matlab
bit = randi([0 1], 1, Nbit);
```

### Quy tắc mã CMI

Trong bài này dùng mức `-1` và `+1`.

```matlab
Bit 0 -> nửa đầu chu kỳ là -1, nửa sau là +1
Bit 1 -> giữ nguyên một mức trong cả chu kỳ bit
```

Với bit `1`, mức tín hiệu phải đảo dấu sau mỗi lần xuất hiện bit 1:

```matlab
muc_1 = -muc_1;
```

### Chỉ số mẫu của bit thứ k

```matlab
start = (k - 1)*Ns + 1;
stop = k*Ns;
mid = start + Ns/2 - 1;
```

Lưu ý:

```matlab
Bit 0 dùng start:mid và mid+1:stop.
Bit 1 dùng start:stop.
Ns nên là số chẵn để chia đôi chu kỳ bit chính xác.
```

### Vẽ 10 bit đầu

```matlab
so_bit_ve = 10;
so_mau_ve = so_bit_ve*Ns;
t = 0:Ts:Ts*(so_mau_ve - 1);

plot(t*1e9, x(1:so_mau_ve));
xlim([0 so_bit_ve*Tb*1e9]);
```

Lưu ý:

```matlab
Nếu plot(t*1e9) thì trục thời gian là ns.
Khi đó xlim cũng phải nhân 1e9.
```

---

## Bài 3: Điều chế và giải điều chế PM

### Mục tiêu

- Tạo tín hiệu bản tin.
- Điều chế pha PM.
- Truyền qua kênh AWGN.
- Giải điều chế PM.
- Vẽ tín hiệu bản tin, tín hiệu điều chế và tín hiệu sau giải điều chế.

### Tín hiệu bản tin

```matlab
x(t) = cos(40*pi*t - pi) + 3*cos(30*pi*t)
```

Tần số thành phần:

```matlab
cos(40*pi*t - pi) -> f = 20 Hz
3*cos(30*pi*t)    -> f = 15 Hz
```

### Điều chế PM dùng hàm

```matlab
y = pmmod(x, fc, Fs, beta, phic);
```

Ý nghĩa:

```matlab
fc   : tần số sóng mang
Fs   : tần số lấy mẫu
beta : chỉ số điều chế pha
phic : pha ban đầu của sóng mang
```

### Điều chế PM không dùng hàm

Công thức:

```matlab
y(t) = cos(2*pi*fc*t + beta*x(t) + phic)
```

Code:

```matlab
y = cos(2*pi*fc*t + beta*x + phic);
```

### Thêm nhiễu AWGN theo công suất nhiễu

```matlab
Pn = 2;
noise = sqrt(Pn)*randn(size(y));
y_noise = y + noise;
```

Lưu ý:

```matlab
Dùng randn để tạo nhiễu Gaussian có cả âm và dương.
Pn càng lớn thì tín hiệu càng nhiễu.
```

### Giải điều chế PM dùng hàm

```matlab
x_rec = pmdemod(y_noise, fc, Fs, beta, phic);
x_rec = movmean(x_rec, 1000);
```

### Giải điều chế PM không dùng hàm - ý tưởng

PM thay đổi pha theo tín hiệu bản tin:

```matlab
pha_tuc_thoi = 2*pi*fc*t + beta*x(t) + phic
```

Muốn khôi phục gần đúng `x(t)`:

```matlab
pha_sau_khi_bo_song_mang ≈ beta*x(t)
x_rec ≈ pha_sau_khi_bo_song_mang / beta
```

Trong thực tế, giải điều chế PM thủ công khó hơn AM vì cần tách pha tức thời và unwrap pha.

### Lưu ý quan trọng

```matlab
Tín hiệu PM có biên độ gần như cố định khoảng -1 đến 1.
Nếu Pn lớn, tín hiệu sau giải điều chế rất dễ xấu.
beta nhỏ thì pha thay đổi ít, dễ bị nhiễu làm sai.
Có thể giảm Pn hoặc tăng beta để tín hiệu thu đẹp hơn.
```

Ví dụ:

```matlab
Pn = 0.01;
beta = 2;
```

thường cho kết quả đẹp hơn:

```matlab
Pn = 2;
beta = 0.5;
```

---

## Công thức cần nhớ

```matlab
Ts = 1/Fs
df = Fs/N
Tb = 1/Rb
Ts_bit = Tb/Ns
```

```matlab
x(t) = cos(2*pi*f*t + phi)
```

```matlab
f = he_so_cua_t / (2*pi)
```

```matlab
y_PM(t) = cos(2*pi*fc*t + beta*x(t) + phic)
```

```matlab
noise = sqrt(Pn)*randn(size(y))
```

```matlab
x_rec = movmean(x_rec, N_lop)
```

---

## Ghi nhớ nhanh

- FFT dùng `fft`, phổ 2 phía dùng thêm `fftshift`.
- Độ phân giải tần số: `df = fs/N`.
- CMI: bit 0 chuyển mức giữa chu kỳ, bit 1 giữ nguyên mức và đảo dấu ở lần bit 1 tiếp theo.
- PM: tín hiệu bản tin làm thay đổi pha của sóng mang.
- PM nhạy với nhiễu pha hơn AM, nhất là khi `Pn` lớn hoặc `beta` nhỏ.
- `randn` dùng để tạo nhiễu Gaussian, không dùng `rand`.
- `movmean` giúp làm mượt nhưng cửa sổ quá lớn có thể làm méo tín hiệu.