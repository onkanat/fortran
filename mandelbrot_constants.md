# Mandelbrot Sabitleri (`mandelbrot_constants`)

Bu modül, Mandelbrot örneğinde kullanılan temel sabitleri içerir.

## Amaç

- Sanal birim $i = \sqrt{-1}$ değerini tek bir yerden tanımlamak
- Ana programın daha okunur olmasını sağlamak

Bu örnekte sanal birim `imaginary_unit` adıyla verilir.

## Derleme Notu

Bu modül tek başına çalıştırılmaz; `Mandelbrot.f90` derlenirken diğer modüllerle birlikte derlenmelidir.

```sh
gfortran mandelbrot_types.f90 mandelbrot_constants.f90 mandelbrot_utils.f90 Mandelbrot.f90 -o mandelbrot
```

## Öne Çıkan Noktalar

- `private/public` ile dışarıya sadece gerekli semboller açılır.
- `complex(dp), parameter` ile sabit karmaşık sayı tanımlanır.
