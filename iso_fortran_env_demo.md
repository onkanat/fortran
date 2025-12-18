# `iso_fortran_env` Kullanımı (`iso_fortran_env_demo`)

Bu örnek, Modern Fortran'da **`iso_fortran_env`** modülünü kullanarak:

- taşınabilir tür kind'lerini (`int32`, `real64` gibi)
- standart çıktı/hata birimlerini (`output_unit`, `error_unit`)

kullanmayı gösterir.

## Derleme ve Çalıştırma

```sh
gfortran iso_fortran_env_demo.f90 -o iso_fortran_env_demo
./iso_fortran_env_demo
```

## Öne Çıkan Noktalar

- `real(kind=8)` pratikte çoğu sistemde işe yarar; fakat `real64` gibi sabit bir tanım daha taşınabilirdir.
- `output_unit` ve `error_unit`, çıktı yönlendirme (redirect) senaryolarında faydalıdır.

## Alıştırmalar

1. `real(real64)` ile `epsilon`, `huge`, `tiny` değerlerini yazdırın.
2. `int32` yerine `int16`/`int8` gibi türler var mı araştırın (derleyiciye bağlı).
