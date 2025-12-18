# `iso_c_binding` ile C Fonksiyonu Çağırma (`iso_c_binding_add`)

Bu örnek, Modern Fortran'da `iso_c_binding` kullanarak **C dilindeki bir fonksiyonu çağırmayı** gösterir.

## Amaç

- `bind(C, name=...)` ile sembol bağlamak
- `c_double` gibi C uyumlu türleri kullanmak
- `value` ile C fonksiyonlarına değer aktarımını göstermek

## Dosyalar

- `iso_c_binding_add.f90`: Fortran ana programı
- `iso_c_binding_add.c`: çağrılan C fonksiyonu (`add_double`)

## Derleme ve Çalıştırma

```sh
gfortran iso_c_binding_add.f90 iso_c_binding_add.c -o iso_c_binding_add
./iso_c_binding_add
```

## Öne Çıkan Noktalar

- `use, intrinsic :: iso_c_binding` modern ve taşınabilir arayüz sağlar.
- C fonksiyonunun adı (`add_double`) ile `bind(C, name='add_double')` eşleşmelidir.

## Alıştırmalar

1. `add_double` yerine iki elemanlı bir dizi toplayan C fonksiyonu yazın.
2. Fortran tarafında `intent(in)` ile dizi argümanı geçirip `c_ptr/c_f_pointer` kullanımını araştırın (ileri). 
