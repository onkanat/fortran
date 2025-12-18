# Güvenli Dosya G/Ç (`robust_file_io`)

Bu örnek, Fortran'da dosya açma/yazma/okuma işlemlerini **hata yakalayarak** yapmayı gösterir.

## Amaç

- `open(newunit=..., iostat=..., iomsg=...)` ile güvenli dosya açma
- Formatlı yazma ile basit bir tablo üretme
- Dosyayı geri okuyup ortalama hesaplama

## Derleme ve Çalıştırma

```sh
gfortran robust_file_io.f90 -o robust_file_io
./robust_file_io
```

Çalışınca `numbers.txt` dosyası oluşturulur.

## Öne Çıkan Noktalar

- `newunit=` birim numarasını güvenli şekilde verir (çakışma riskini azaltır).
- `iostat/iomsg` ile hata kodu ve açıklaması alınır.
- Okuma döngüsü `iostat` sıfır olmadığı anda sonlandırılır.

## Alıştırmalar

1. Dosya adını komut satırından alacak şekilde genişletin.
2. Okunan sayılar için minimum/maksimum hesaplayın.
3. Başlık satırını `#` ile başlayan tüm satırları atlayacak şekilde genelleştirin.
