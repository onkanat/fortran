# Modül Kullanımı ve Generic Interface (`statistics_module_demo`)

Bu örnek, `statistics_utils` modülünü kullanarak `mean` ve `stddev` fonksiyonlarını çağırır.

## Amaç

- Ayrı bir modülü `use` ile içeri almak
- `mean` fonksiyonunun **generic** olarak hem `real` hem `integer` diziyle çalıştığını göstermek

## Derleme ve Çalıştırma

```sh
gfortran statistics_utils.f90 statistics_module_demo.f90 -o statistics_module_demo
./statistics_module_demo
```

## Öne Çıkan Noktalar

- `mean(xr)` ve `mean(xi)` çağrıları aynı isimle yapılır; derleyici doğru prosedürü seçer.
- `stddev` burada sadece `real` dizi için tanımlıdır.

## Alıştırmalar

1. `stddev` için integer overload ekleyin.
2. `mean/stddev` fonksiyonlarını `elemental` yapmayı deneyin (hangileri mantıklı?).
