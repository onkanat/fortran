# Dinamik Dizi ile Ortalama Alma (`main`)

Bu örnek, kullanıcıdan alınan sayıları **dinamik (allocatable) bir dizi** içinde saklayıp çeşitli ortalamaları hesaplar:

- Tüm değerlerin ortalaması
- Sadece pozitif değerlerin ortalaması
- Sadece negatif değerlerin ortalaması

## Derleme ve Çalıştırma

```sh
gfortran main.f90 -o main
./main
```

## Örnek Kullanım

Girdi:
- Veri sayısı: `5`
- Değerler: `-2 1 3 -4 2`

Beklenen çıktı (değerler değişebilir):
- Ortalama
- Pozitiflerin ortalaması
- Negatiflerin ortalaması

## Öne Çıkan Noktalar

- `real(kind=8)` kullanılarak daha yüksek hassasiyet tercih edilmiştir.
- `allocate(..., stat=..., errmsg=...)` ile bellek ayırma hataları yakalanır.
- `sum` ve `count` intrinsics ile maske (`mask=`) kullanılarak koşullu toplama yapılır.
- Basit girdi doğrulama için `iostat/iomsg` kullanılır.

## Alıştırmalar

1. Kullanıcıdan sayıları tek tek okuyup (döngüyle) diziye yerleştirin.
2. Medyanı da hesaplayan bir fonksiyon ekleyin.
3. Pozitif/negatif yerine “eşik değerden büyük” ortalaması ekleyin.
