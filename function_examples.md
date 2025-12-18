# Fonksiyon Örnekleri (`function_examples`)

Bu örnek, Modern Fortran'da **fonksiyon yazmayı ve çağırmayı** gösterir. Kod, özellikle **internal fonksiyonları** (`contains` bloğu) kullanır.

Internal fonksiyonların önemli avantajı: **explicit interface** otomatik oluşur; dışarıda ayrıca `interface` bloğu yazmanız gerekmez.

## Derleme ve Çalıştırma

```sh
gfortran function_examples.f90 -o function_examples
./function_examples
```

## Programın Gösterdikleri

- `add_numbers(a, b)`: iki sayıyı toplar
- `rectangle_area(length, width)`: dikdörtgen alanını hesaplar
- `circle_area(radius)`: daire alanını hesaplar
- `maximum_value(a, b)`: iki sayıdan büyüğünü döndürür

## Öne Çıkan Noktalar

- `contains` ile prosedürleri program içinde tanımlama
- `intent(in)` ile argüman niyeti belirtme
- `real(kind=8)` ve `pi` sabiti ile sayısal tutarlılık

## Alıştırmalar

1. `maximum_value` fonksiyonunu `integer` için de çalışacak şekilde *generic interface* ile genişletin.
2. `circle_area` için çapla çağırma seçeneği ekleyin.
3. Bir `pure` fonksiyon örneği ekleyin (yan etkisiz).
