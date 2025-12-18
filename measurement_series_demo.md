# Derived Type ve Type-Bound Procedure (`measurement_series_demo`)

Bu örnek, Modern Fortran'da **türetilmiş tür** (derived type) tanımlayıp bu türe **metot benzeri** prosedürler (type-bound procedures) bağlamayı gösterir.

## Amaç

- `type :: ...` ile veri + davranışı bir araya getirmek
- `allocatable` bileşen (`values(:)`) kullanmak
- `series%mean()` gibi çağrılarla okunabilir bir API oluşturmak

## Derleme ve Çalıştırma

```sh
gfortran measurement_series_demo.f90 -o measurement_series_demo
./measurement_series_demo
```

## Öne Çıkan Noktalar

- `class(measurement_series)` ile type-bound prosedürler yazılır.
- `allocated(...)` kontrolüyle güvenli kullanım sağlanır.
- `minval/maxval/sum` gibi dizi intrinsics ile kısa ve okunur kod yazılır.

## Alıştırmalar

1. `append(value)` gibi bir metot ekleyin (yeniden allocate etme stratejisi).
2. `stddev()` metodunu ekleyin (örnek std sapma).
3. Türü bir modül içine taşıyıp ayrı derleme düzeni kurun.
