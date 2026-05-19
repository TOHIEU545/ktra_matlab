# README - Bài tập MATLAB

File này tóm tắt nhanh các bài đã làm, mỗi bài dùng phương pháp gì, thông số nào cần chú ý và các hàm MATLAB quan trọng.

---

## Bài 1 - Tín hiệu và biến đổi Fourier

**Mục tiêu:** mô phỏng tín hiệu trong miền thời gian, biến đổi Fourier và vẽ phổ tần số.

Tín hiệu:

```matlab
x = cos(40*pi*t - pi) + 3*cos(30*pi*t);
```

**Thông số cần quan tâm:**

- `Fs`: tần số lấy mẫu.
- `T = 1/Fs`: chu kỳ lấy mẫu.
- `t`: trục thời gian.
- `N = length(x)`: số mẫu tín hiệu.
- `df = Fs/N`: bước nhảy tần số.

**Công thức quan trọng:**

```matlab
X = fft(x);
X_shift = fftshift(X);
f = -Fs/2 : df : Fs/2 - df;
X_mag = abs(X_shift)/N;
```

**Hàm dùng:**

- `plot`: vẽ tín hiệu miền thời gian.
- `fft`: biến đổi Fourier.
- `fftshift`: dịch phổ về giữa trục tần số.
- `stem`: vẽ phổ dạng vạch.

---

## Bài 2 - Mã đường CMI

**Mục tiêu:** tạo chuỗi bit nhị phân, mã hóa thành dạng sóng CMI và vẽ 10 chu kỳ bit đầu.

**Thông số cần quan tâm:**

- `Rb`: tốc độ bit.
- `Tb = 1/Rb`: chu kỳ bit.
- `Nbit`: số bit.
- `Ns`: số mẫu trên một bit.
- `Ts = Tb/Ns`: khoảng cách giữa hai mẫu.

**Quy tắc mã CMI:**

```text
Bit 0 -> nửa đầu -1, nửa sau +1
Bit 1 -> giữ nguyên +1 hoặc -1 trong cả chu kỳ bit, các bit 1 đảo dấu luân phiên
```

**Hàm dùng:**

- `randi([0 1], 1, Nbit)`: tạo chuỗi bit ngẫu nhiên.
- `zeros`: tạo mảng tín hiệu ban đầu.
- `for`, `if`: mã hóa từng bit.
- `plot`: vẽ dạng sóng CMI.

**Lưu ý:**

Vì `Rb = 500e6`, nên:

```matlab
Tb = 1/Rb = 2e-9 s = 2 ns
```

Do đó khi vẽ thường dùng:

```matlab
t * 1e9
```

để đổi trục thời gian từ giây sang nano giây.

---

## Bài 3 - Điều chế pha PM, kênh AWGN và giải điều chế

**Mục tiêu:** điều chế pha tín hiệu tương tự, truyền qua kênh AWGN, giải điều chế và vẽ kết quả.

Tín hiệu bản tin:

```matlab
x = cos(40*pi*t - pi) + 3*cos(30*pi*t);
```

### a. Điều chế pha PM

**Thông số cần quan tâm:**

- `fc`: tần số sóng mang.
- `Fs`: tần số lấy mẫu.
- `phic`: pha ban đầu của sóng mang.
- `beta`: hệ số lệch pha / chỉ số điều chế pha.

**Hàm dùng:**

```matlab
y = pmmod(x, fc, Fs, beta, phic);
```

Hoặc theo công thức:

```matlab
y = Ac*cos(2*pi*fc*t + kp*x);
```

### b. Kênh AWGN

**Thông số cần quan tâm:**

- `Pn`: công suất nhiễu.
- `randn`: tạo nhiễu Gauss trắng.

**Công thức dùng:**

```matlab
nhieu = sqrt(Pn)*randn(size(y));
y_noise = y + nhieu;
```

Vì `randn` tạo nhiễu có phương sai 1, nên muốn công suất nhiễu là `Pn` thì nhân với `sqrt(Pn)`.

### c. Giải điều chế PM

**Hàm dùng:**

```matlab
x_rec = pmdemod(y_noise, fc, Fs, beta, phic);
```

Nếu tín hiệu sau giải điều chế bị nhiễu mạnh, có thể làm mượt để dễ quan sát:

```matlab
x_rec = movmean(x_rec, 1000);
```

### d. Vẽ kết quả

**Hàm dùng:**

- `subplot(3,1,1)`: vẽ tín hiệu bản tin.
- `subplot(3,1,2)`: vẽ tín hiệu sau điều chế.
- `subplot(3,1,3)`: vẽ tín hiệu sau giải điều chế.
- `plot`, `grid on`, `xlabel`, `ylabel`, `title`.

---

## Tóm tắt hàm MATLAB quan trọng

| Hàm | Công dụng |
|---|---|
| `plot` | Vẽ đồ thị liên tục |
| `stem` | Vẽ phổ dạng vạch |
| `subplot` | Chia một hình thành nhiều đồ thị nhỏ |
| `fft` | Biến đổi Fourier nhanh |
| `fftshift` | Dịch phổ để tần số 0 nằm giữa |
| `randi` | Tạo bit ngẫu nhiên |
| `randn` | Tạo nhiễu Gauss trắng |
| `pmmod` | Điều chế pha PM |
| `pmdemod` | Giải điều chế pha PM |
| `movmean` | Làm mượt tín hiệu |