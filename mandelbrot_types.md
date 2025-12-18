# Mandelbrot Tür Tanımları (`mandelbrot_types`)

Bu modül, Mandelbrot örneğinde kullanılacak **kayan nokta hassasiyetini** tek bir yerden yönetmek için oluşturulmuştur.

## Amaç

- Kodun her yerinde aynı gerçek sayı türünü (kind) kullanmak
- Taşınabilir ve okunur bir “dp” (double precision benzeri) tanımı sağlamak

Bu örnekte `dp`, `iso_fortran_env` içindeki `real64` üzerinden tanımlanır.

## Derleme Notu

Bu modül tek başına çalıştırılmaz; `Mandelbrot.f90` derlenirken diğer modüllerle birlikte derlenmelidir.

Örnek:

```sh
gfortran mandelbrot_types.f90 mandelbrot_constants.f90 mandelbrot_utils.f90 Mandelbrot.f90 -o mandelbrot
```

## Öne Çıkan Noktalar

- `use, intrinsic :: iso_fortran_env` modern ve güvenilir bir yaklaşımdır.
- `private/public` ile modül arayüzü kontrol altında tutulur.
