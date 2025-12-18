# Tarih Doğrulama (date_check)

Bu örnek, **koşul kontrollü döngü** (`do ... end do` + `cycle`/`exit`) ile kullanıcıdan doğru girdi gelene kadar tekrar isteme yaklaşımını gösterir. Ayrıca ay bazlı gün sayısını belirlemek için `select case` kullanır.

## Problem
Kullanıcıdan (ay, gün, yıl) alınır ve şu kurallara göre doğrulanır:

- Yıl: 1970–2020
- Ay: 1–12
- Gün: aya göre 28/29/30/31

Şubat için basit artık yıl kontrolü yapılır:
- `mod(year, 4) == 0` ise 29 gün, değilse 28 gün

> Not: Bu artık yıl kuralı sınırlı bir örnektir; gerçek takvim kuralları daha kapsamlıdır.

## Derleme ve Çalıştırma

```sh
gfortran date_check.f90 -o date_check
./date_check
```

## Örnek Testler
- Geçerli: `2 29 2020`
- Geçersiz: `2 29 2019` (Şubat 2019 = 28 gün)
- Geçersiz: `13 1 2019` (ay aralık dışı)

## Koddan Önemli Noktalar
- `do` döngüsü içinde, hatalı girişlerde `cycle` ile başa dönülür.
- Geçerli bir tarih yakalanınca `exit` ile döngü sonlandırılır.
- Hatalı format girişlerini yakalamak için `iostat`/`iomsg` kullanılır.
- `select case` ile ay grubuna göre `day_max` belirlenir.

İlgili kaynak: `date_check.f90`
