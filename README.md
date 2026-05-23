# README - 3 bài MATLAB: FFT, RZ 75% và điều chế AM

## Bài 1: Mô phỏng tín hiệu và biến đổi Fourier

### Mục tiêu

- Tạo tín hiệu trong miền thời gian.
- Tính FFT.
- Vẽ phổ biên độ 2 phía.

### Tín hiệu

```matlab
x(t) = cos(5*pi*t + pi/2) + 10*cos(50*pi*t - pi/2)
```

So sánh với công thức:

```matlab
cos(2*pi*f*t + phi)
```

Suy ra:

```matlab
cos(5*pi*t + pi/2)       -> f = 2.5 Hz
10*cos(50*pi*t - pi/2)   -> f = 25 Hz
```

### Lấy mẫu

```matlab
fs = 1000;
ts = 1/fs;
t = 0:ts:2-ts;
```

Ý nghĩa:

```matlab
fs : tần số lấy mẫu
ts : chu kỳ lấy mẫu
```

Thời gian mô phỏng là 2 giây nên:

```matlab
N = 2000
df = fs/N = 1000/2000 = 0.5 Hz
```

Vì `df = 0.5 Hz`, tần số `2.5 Hz` rơi đúng vào điểm FFT nên phổ đẹp hơn.

### FFT

```matlab
N = length(x);
X = fft(x);
X_shift = fftshift(X);
```

Tạo trục tần số:

```matlab
df = fs/N;
f = -fs/2 : df : fs/2 - df;
```

Phổ biên độ:

```matlab
pho_bien_do = abs(X_shift)/N;
```

Lưu ý:

```matlab
fftshift dùng để đưa phổ về khoảng -fs/2 đến fs/2.
Phổ 2 phía có vạch tại ±2.5 Hz và ±25 Hz.
```

---

## Bài 2: Tạo chuỗi bit và mã RZ 75%

### Mục tiêu

- Tạo chuỗi bit nhị phân 100 bit.
- Chuyển chuỗi bit sang mã RZ 75%.
- Vẽ dạng sóng trong 10 chu kỳ bit đầu.

### Thông số

```matlab
Rb = 100e6;
Tb = 1/Rb;
Nbit = 100;
Ns = 1000;
ts = Tb/Ns;
```

Ý nghĩa:

```matlab
Rb   : tốc độ bit
Tb   : chu kỳ bit
Nbit : số bit
Ns   : số mẫu trên 1 bit
ts   : thời gian giữa 2 mẫu
```

Công thức cần nhớ:

```matlab
Tb = 1/Rb
ts = Tb/Ns
```

### Tạo chuỗi bit

```matlab
bit = randi([0 1], 1, Nbit);
```

### Mã RZ 75%

RZ nghĩa là tín hiệu giữ mức trong một phần chu kỳ bit, sau đó trở về 0.

```matlab
duty = 0.75;
Ns_xung = round(duty*Ns);
```

Quy tắc mã hóa:

```matlab
Bit 1 -> mức 1 trong 75% chu kỳ bit, sau đó về 0
Bit 0 -> mức 0 trong toàn bộ chu kỳ bit
```

Lưu ý nên dùng:

```matlab
Ns_xung = round(duty*Ns);
```

thay vì:

```matlab
Ns_xung = duty*Ns;
```

để tránh lỗi chỉ số mảng khi `duty*Ns` không phải số nguyên.

### Chỉ số mẫu của bit thứ k

```matlab
start = (k - 1)*Ns + 1;
stop = k*Ns;
stop_xung = start + Ns_xung - 1;
```

### Vẽ 10 bit đầu

```matlab
so_bit_ve = 10;
so_mau_ve = so_bit_ve*Ns;
t = 0:ts:ts*(so_mau_ve - 1);

plot(t*1e6, x(1:so_mau_ve));
xlim([0 so_bit_ve*Tb*1e6]);
```

Lưu ý:

```matlab
Nếu plot(t*1e6) thì trục thời gian là micro giây.
Khi đó xlim cũng phải nhân 1e6.
```

---

## Bài 3: Điều chế và giải điều chế AM

### Mục tiêu

- Tạo tín hiệu bản tin.
- Điều chế biên độ AM.
- Truyền qua kênh nhiễu AWGN.
- Giải điều chế AM.
- Vẽ tín hiệu bản tin, tín hiệu điều chế có nhiễu và tín hiệu giải điều chế.

### Tín hiệu bản tin

```matlab
x(t) = cos(5*pi*t + pi/2) + 10*cos(50*pi*t - pi/2)
```

Tần số thành phần:

```matlab
cos(5*pi*t + pi/2)       -> f = 2.5 Hz
10*cos(50*pi*t - pi/2)   -> f = 25 Hz
```

### Điều chế AM dùng hàm

```matlab
y = ammod(x, fc, fs, phic, A);
```

Thông số:

```matlab
fc = 10000;
A = 20;
phic = pi/4;
```

Ý nghĩa:

```matlab
fc   : tần số sóng mang
A    : biên độ sóng mang
phic : pha ban đầu của sóng mang
```

### Điều chế AM không dùng hàm

Công thức:

```matlab
y(t) = [A + x(t)]*cos(2*pi*fc*t + phic)
```

Code:

```matlab
carrier = cos(2*pi*fc*t + phic);
y = (A + x).*carrier;
```

Lưu ý:

```matlab
A > max(abs(x))
```

để tránh méo bao tín hiệu. Với bài này biên độ lớn nhất của `x(t)` xấp xỉ 11 nên `A = 20` là hợp lý.

### Thêm nhiễu AWGN theo công suất nhiễu

```matlab
Pn = 3;
noise = sqrt(Pn)*randn(size(y));
y_noise = y + noise;
```

Lưu ý:

```matlab
randn tạo nhiễu Gaussian có cả âm và dương.
Không dùng rand vì rand chỉ từ 0 đến 1, làm tín hiệu bị lệch DC.
```

### Giải điều chế AM dùng hàm

```matlab
x_rec = amdemod(y_noise, fc, fs, phic, A);
x_rec = movmean(x_rec, 500);
```

### Giải điều chế AM không dùng hàm

Nhân lại với sóng mang:

```matlab
z = 2*y_noise.*cos(2*pi*fc*t + phic);
```

Lọc thông thấp:

```matlab
z_lpf = movmean(z, 500);
```

Trừ thành phần DC:

```matlab
x_rec = z_lpf - A;
```

Công thức tóm tắt:

```matlab
z(t) = 2*y_noise(t)*cos(2*pi*fc*t + phic)
x_rec(t) = LPF{z(t)} - A
```

---

## Công thức cần nhớ

```matlab
ts = 1/fs
df = fs/N
Tb = 1/Rb
ts_bit = Tb/Ns
Ns_xung = round(duty*Ns)
```

```matlab
f = he_so_cua_t / (2*pi)
```

```matlab
y_AM(t) = [A + x(t)]*cos(2*pi*fc*t + phic)
```

```matlab
noise = sqrt(Pn)*randn(size(y))
```

```matlab
z(t) = 2*y_noise(t)*cos(2*pi*fc*t + phic)
x_rec(t) = LPF{z(t)} - A
```

---

## Ghi nhớ nhanh

- FFT dùng `fft`, phổ 2 phía dùng thêm `fftshift`.
- Độ phân giải tần số: `df = fs/N`.
- Lấy thời gian mô phỏng 2 giây giúp `df = 0.5 Hz`, bắt đúng tần số 2.5 Hz.
- RZ 75%: bit 1 giữ mức trong 75% chu kỳ bit rồi về 0.
- AM cần `A > max(abs(x))`.
- AWGN nên dùng `randn`, không dùng `rand`.
- `fc` phải lớn hơn nhiều so với tần số lớn nhất của tín hiệu bản tin.
- `movmean` giúp làm mượt nhưng cửa sổ quá lớn có thể làm méo tín hiệu.