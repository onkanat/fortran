# İstatistik Modülü (`statistics_utils`)

Bu dosya, bir **modül** içinde basit istatistik fonksiyonları tanımlar:

- `mean(...)`: dizi ortalaması (generic)
- `stddev(...)`: örnek standart sapma (real dizi için)

## Amaç

- `module` ile tekrar kullanılabilir kod yazmak
- `public/private` ile API'yi kontrollü açmak
- `pure` fonksiyonlarla yan etkisiz hesap yapmak
- `generic interface` ile overload göstermek (`mean` hem integer hem real için)

## Derleme Notu

Bu dosya tek başına çalıştırılmaz; örnek programla birlikte derlenir.

Örnek:

```sh
gfortran statistics_utils.f90 statistics_module_demo.f90 -o statistics_module_demo
```

## Alıştırmalar

1. `stddev` için integer diziyi de destekleyecek overload ekleyin.
2. Boş dizi (`size==0`) durumunda hata vermek için bir strateji düşünün.
