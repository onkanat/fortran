# Karelerin Toplamı ve Toplamın Karesi Farkı (sos_difference)

Bu örnek, **sayaç kontrollü `do` döngüsü** ile birikimli toplama yapmayı ve basit bir matematik problemini çözmeyi gösterir.

## Problem
İlk $N$ doğal sayı için:

- Karelerin toplamı:
  $$\text{sum\_of\_squares} = 1^2 + 2^2 + \dots + N^2$$
- Toplamın karesi:
  $$\text{square\_of\_sum} = (1 + 2 + \dots + N)^2$$

Aranan:

$$\text{difference} = \text{square\_of\_sum} - \text{sum\_of\_squares}$$

## Derleme ve Çalıştırma

```sh
gfortran sos_difference.f90 -o sos_difference
./sos_difference
```

## Örnek
- Girdi: `10`
- Beklenen sonuç: fark = 2640

## Koddan Önemli Noktalar
- `do i = 1, n` döngüsü ile iki ayrı toplam (kareler toplamı ve normal toplam) hesaplanır.
- `iostat` / `iomsg` ile hatalı girişler yakalanır.
- Değişken isimleri repo standardına uygun olarak `snake_case` kullanır.

İlgili kaynak: `sos_difference.f90`
