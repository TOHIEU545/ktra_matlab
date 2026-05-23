# README - 3 bài MATLAB: FFT, RZ và AM

## Bài 1: Mô phỏng tín hiệu và biến đổi Fourier

### Mục tiêu

- Tạo tín hiệu trong miền thời gian.
- Tính FFT.
- Vẽ phổ biên độ 1 phía và 2 phía.

### Tín hiệu

```matlab
x(t) = cos(20*pi*t + pi/2) + 2*sin(30*pi*t)
```

Dạng tổng quát:

```matlab
cos(2*pi*f*t + phi)
sin(2*pi*f*t + phi)
```

Suy ra:

```matlab
cos(20*pi*t + pi/2)  -> f = 10 Hz
sin(30*pi*t)         -> f = 15 Hz
```

### Lấy mẫu

```matlab
fs = 1000;
ts = 1/fs;
T = 1;
t = 0:ts:T-ts;
```

Ý nghĩa:

```matlab
fs : tần số lấy mẫu
ts : chu kỳ lấy mẫu
T  : thời gian mô phỏng
```

### FFT

```matlab
N = length(x);
X = fft(x);
df = fs/N;
```

Công thức cần nhớ:

```matlab
df = fs/N
```

`df` là độ phân giải tần số.

### Phổ 2 phía

```matlab
X_shift = fftshift(X);
f_2_phia = -fs/2 : df : fs/2 - df;
pho_2_phia = abs(X_shift)/N;
```

Lưu ý:

```matlab
fftshift dùng để đưa phổ về khoảng -fs/2 đến fs/2.
Phổ 2 phía có cả tần số âm và tần số dương.
```

### Phổ 1 phía

```matlab
pho_goc = abs(X)/N;
pho_1_phia = pho_goc(1:N/2+1);
pho_1_phia(2:end-1) = 2*pho_1_phia(2:end-1);
f_1_phia = 0:df:fs/2;
```

Lưu ý:

```matlab
Phổ 1 phía chỉ lấy từ 0 đến fs/2.
Nhân đôi các thành phần ở giữa.
Không nhân đôi DC và Nyquist.
```

---

## Bài 2: Tạo chuỗi bit và mã RZ

### Mục tiêu

- Tạo chuỗi bit nhị phân 100 bit.
- Chuyển chuỗi bit sang dạng sóng RZ.
- Vẽ 10 chu kỳ bit đầu tiên.

### Thông số

```matlab
Rb = 1e9;
Tb = 1/Rb;
Nbit = 100;
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

### Mã RZ

RZ nghĩa là tín hiệu giữ mức trong một phần chu kỳ bit, sau đó trở về 0.

```matlab
duty = 0.25;   % RZ 25%
duty = 0.75;   % RZ 75%
```

Số mẫu giữ mức xung:

```matlab
Ns_xung = round(duty*Ns);
```

Nên dùng `round` để tránh lỗi chỉ số mảng.

### Quy tắc mã RZ lưỡng cực

```matlab
Bit 1 -> mức  1 trong duty*Tb, sau đó về 0
Bit 0 -> mức -1 trong duty*Tb, sau đó về 0
```

Nếu là RZ đơn cực:

```matlab
Bit 1 -> mức 1 trong duty*Tb, sau đó về 0
Bit 0 -> mức 0 trong toàn bộ Tb
```

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

## Bài 3: Điều chế và giải điều chế AM

### Mục tiêu

- Tạo tín hiệu bản tin.
- Điều chế AM.
- Truyền qua kênh AWGN.
- Giải điều chế AM.
- Vẽ tín hiệu trước và sau xử lý.

### Tín hiệu bản tin

```matlab
x(t) = cos(20*pi*t + pi/2) + 2*sin(30*pi*t)
```

Tần số thành phần:

```matlab
cos(20*pi*t + pi/2) -> f = 10 Hz
sin(30*pi*t)        -> f = 15 Hz
```

### Điều chế AM dùng hàm

```matlab
y = ammod(x, fc, Fs, phic, A);
```

### Điều chế AM không dùng hàm

### Cách 1: dùng chỉ số điều chế m

```matlab
Am = max(abs(x));
x_norm = x/Am;
xc = Ac*cos(2*pi*fc*t + phic);
y = (1 + m*x_norm).*xc;
```

Cách này phù hợp khi đề cho `m`.

### Cách 2: dùng trực tiếp Ac và x

```matlab
carrier = cos(2*pi*fc*t + phic);
y = (Ac + x).*carrier;
```

Cách này tương đương với trường hợp:

```matlab
m = Am/Ac
```

Lưu ý tránh nhầm:

```matlab
Nếu đề cho rõ m = 0.5 thì nên dùng cách 1.
Nếu không đề cập m mà chỉ cần AM có sóng mang thì có thể dùng cách 2.

### Thêm nhiễu AWGN dùng hàm

```matlab
y_noise = awgn(y, SNR, 'measured');
```

### Thêm nhiễu AWGN không dùng hàm

Công suất tín hiệu:

```matlab
Ps = mean(y.^2);
```

Công suất nhiễu theo SNR:

```matlab
Pn = Ps / 10^(SNR/10);
```

Tạo nhiễu:

```matlab
noise = sqrt(Pn)*randn(size(y));
y_noise = y + noise;
```

Lưu ý:

```matlab
Dùng randn để tạo nhiễu Gaussian có cả âm và dương.
Không dùng rand vì rand chỉ từ 0 đến 1, dễ gây lệch DC.
```

### Giải điều chế AM dùng hàm

```matlab
x_rec = amdemod(y_noise, fc, Fs, phic, A);
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
Ts = 1/Fs
df = Fs/N
Tb = 1/Rb
Ts_bit = Tb/Ns
Ns_xung = round(duty*Ns)
```

```matlab
y_AM(t) = [A + x(t)]*cos(2*pi*fc*t + phic)
```

```matlab
Ps = mean(y.^2)
Pn = Ps / 10^(SNR/10)
noise = sqrt(Pn)*randn(size(y))
```

```matlab
z(t) = 2*y_noise(t)*cos(2*pi*fc*t + phic)
x_rec(t) = LPF{z(t)} - A
```

---

## Ghi nhớ nhanh

- FFT muốn phổ đẹp thì tín hiệu nên chứa số chu kỳ nguyên trong thời gian lấy mẫu.
- RZ 25%: giữ mức trong 25% chu kỳ bit rồi về 0.
- RZ 75%: giữ mức trong 75% chu kỳ bit rồi về 0.
- AM cần `A > max(abs(x))`.
- AWGN nên dùng `randn`, không dùng `rand`.
- SNR càng cao thì tín hiệu sau giải điều chế càng đẹp.
- `fc` phải lớn hơn nhiều so với tần số lớn nhất của tín hiệu bản tin.
- `Fs` phải đủ lớn so với `fc`.
- `movmean` làm mượt tín hiệu nhưng cửa sổ quá lớn có thể làm méo tín hiệu.