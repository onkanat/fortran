# Not Harfi Atama (grades)

Bu örnek, Fortran’da `select case` yapısının **aralıklarla** (örn. `80:89`) nasıl kullanılacağını gösterir.

## Problem
Kullanıcıdan üç sınav notu alınır, ortalaması hesaplanır ve aşağıdaki ölçeğe göre harf notu verilir:

- A: $\ge 90$
- B: 80–89
- C: 70–79
- D: 60–69
- F: $\le 59$

Program, ortalamayı `nint` ile en yakın tamsayıya yuvarlayıp `select case` üzerinden karar verir.

## `nint` ne yapar? (Yuvarlama notu)

`nint(x)`, gerçek (real) bir sayıyı **en yakın tamsayıya** yuvarlar.

- Örnek: `nint(79.5_8)` genellikle `80` döndürür.
- “Tam ortada” kalan durumlarda (ör. `x = 80.5`) hangi yöne yuvarlanacağı derleyici/uygulamaya göre değişebilir.

Bu örnekte not aralıkları geniş olduğu için, bu belirsizlik genellikle sonucu değiştirmez; ancak hassas sınır durumlarıyla (örn. 89.5/90.5) test yaparken bunu akılda tutun.

> İsterseniz alternatif olarak ortalamayı yuvarlamadan doğrudan `real(kind=8)` olarak tutup `if/else if` ile aralık kontrolü de yapabilirsiniz.

## `select case` aralıkları nasıl çalışır?

`select case (test_ave)` içinde kullanılan aralıklar **dahilî (inclusive)** sınırlar ile değerlendirilir:

- `case (80:89)` → 80, 81, ..., 89 değerlerinin hepsini kapsar.
- `case (:59)` → 59 ve altını kapsar.
- `case (90:)` → 90 ve üstünü kapsar.

## Derleme ve Çalıştırma

```sh
gfortran grades.f90 -o grades
./grades
```

## Örnek
Giriş:
- `70 80 90`

Çıktı (örnek):
- Ortalama ≈ 80 → Harf Notu: B

## Koddan Önemli Noktalar
- `real(kind=8)` ile tutarlı hassasiyet
- Notların 0–100 aralığında doğrulanması
- Hatalı girdi için `iostat`/`iomsg` ile güvenli okuma
- `select case` ile aralık bazlı karar verme

## Önerilen Alıştırmalar

1. Programı değiştirip **yuvarlanmış** ortalama yerine `average_score` değerini doğrudan aralıklara sokacak bir `if/else if` zinciri yazın. Sonuçların `nint` yaklaşımıyla farkını karşılaştırın.
2. `iostat` örneğini genişletin: Hatalı girişte programın bitmesi yerine kullanıcıdan tekrar notları istemesini sağlayın (`do` döngüsü + `cycle`).
3. Notları 0–100 yerine 0–1000 gibi daha geniş aralığa uyarlayın ve harf notu ölçeğini yeniden tanımlayın.

İlgili kaynak: `grades.f90`
