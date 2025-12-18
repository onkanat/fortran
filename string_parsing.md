# Metin İşleme ve Ayrıştırma (`string_parsing`)

Bu örnek, Fortran'da `character` tipleriyle metin işleme ve bir satırı `anahtar=değer` formatında ayrıştırmayı gösterir.

## Amaç

- `character(len=:), allocatable` ile **deferred-length string** kullanmak
- `trim`, `adjustl`, `index` gibi temel metin fonksiyonlarını görmek
- Bir string içinden `read(value,*)` ile sayısal değer okumak (internal read)

## Derleme ve Çalıştırma

```sh
gfortran string_parsing.f90 -o string_parsing
./string_parsing
```

## Örnek Kullanım

Girdi:
- `radius=2.5`

Çıktı:
- Anahtar: `radius`
- Değer: `2.5`
- Alan: $\pi r^2$

## Öne Çıkan Noktalar

- `read(*,'(A)')` ile satır olarak okuma yapılır.
- `index(text,'=')` ile ayırıcı karakterin konumu bulunur.
- Ayrıştırma sonrası `trim(adjustl(...))` ile boşluklar temizlenir.

## Alıştırmalar

1. Büyük/küçük harf duyarsız anahtar eşleştirmesi ekleyin.
2. Birden fazla `anahtar=değer` çiftini aynı satırdan ayrıştırın.
3. `radius` dışında `width`/`height` gibi anahtarlar ekleyin.
