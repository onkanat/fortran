# Mandelbrot Yardımcı Rutinleri (`mandelbrot_utils`)

Bu modül, Mandelbrot örneğinde kullanılan yardımcı rutinleri içerir:

- `linspace`: belirli bir aralıkta eşit aralıklı değerler üretir
- `meshgrid`: iki 1D diziden 2D koordinat ızgarası üretir
- `savetxt`: 2D reel diziyi metin dosyasına yazar

## Derleme ve Kullanım

Bu modül tek başına çalıştırılmaz; `Mandelbrot.f90` ile birlikte derlenir:

```sh
gfortran mandelbrot_types.f90 mandelbrot_constants.f90 mandelbrot_utils.f90 Mandelbrot.f90 -o mandelbrot
./mandelbrot
```

## Öne Çıkan Noktalar

- `savetxt` rutininde `open(newunit=..., iostat=..., iomsg=...)` ile güvenli dosya açma gösterilir.
- `savetxt` satır satır yazdığı için Python `numpy.loadtxt` ile okunması kolaydır.
- `linspace` içinde `n==1` gibi kenar durumları ele alınmıştır.

## Alıştırmalar

1. `savetxt` için isteğe bağlı bir format (`format` argümanı) ekleyin.
2. `meshgrid` rutinini `do concurrent` ile yeniden yazıp (yan etkisiz) deneyin.
