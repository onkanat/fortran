# Standard Deviation Programı
Bu program, bir dosyadan okunan sayıların minimum, maksimum, toplam, ortalama ve standart sapmasını hesaplar; sayıları 10'lu sütunlarla ekrana yazar.

## Derleme ve Çalıştırma
```sh
gfortran standard_deviation.f90 -o standard_deviation
./standard_deviation
```

## Girdi Biçimi
- Dosya adı kullanıcıdan alınır.
- Dosya, her satırda bir sayı olacak biçimde hazırlanmış olmalıdır.
- En fazla 5000 sayı okunur.

## Örnek Akış
```
Standard Deviation Program Example.
Enter File Name: numbers.txt
-------------------------------
Results:
... sayı listesi ...
Minimum =   ...
Maximum =   ...
Sum =       ...
Average =   ...
Standard Deviation =   ...
```

## Öne Çıkan Noktalar
- Başarısız açma için 3 deneme hakkı, 4. hatada program sonlanır.
- Okuma hatasında program durur; `iostat<0` EOF anlamına gelir.
- Standart sapma örneklem formülüyle hesaplanır: `sqrt(stdsum / (n-1))`.
- Sayılar 10'lu sütunlarla `advance="no"` kullanılarak yazdırılır.

## Notlar
- Tüm hesaplamalar `real(kind=8)` hassasiyetindedir.
- `numbers` dizisi 5000 eleman kapasitelidir; aşım durumunda program durur.
