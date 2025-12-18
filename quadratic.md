# İkinci Dereceden Denklem Çözücü (quadratic)

Bu örnek, Fortran’da seçim ifadelerinin (`if/else if/else`) gerçek bir problem üzerinde nasıl kullanıldığını gösterir.

## Problem
Aşağıdaki denklemin kökleri hesaplanır:

$$a x^2 + b x + c = 0$$

Ayırt edici (discriminant):

$$\Delta = b^2 - 4ac$$

- $\Delta > 0$ ise iki farklı gerçek kök
- $\Delta \approx 0$ ise tek (tekrarlı) gerçek kök
- $\Delta < 0$ ise iki karmaşık kök

> Not: Gerçek sayılarda `== 0` karşılaştırması hassasiyet nedeniyle yanıltıcı olabilir. Bu nedenle program, $\Delta$ için küçük bir tolerans kullanır.

## Neden “$\Delta \approx 0$” için tolerans kullanıyoruz?

Bilgisayarda `real` sayılar ikili (binary) gösterimle saklanır. Bu yüzden bazı ondalık sayılar tam temsil edilemez ve hesaplamalar küçük yuvarlama hataları içerir. Bu durum, teoride $\Delta = 0$ olan bir durumda pratikte $\Delta$ değerinin çok küçük ama sıfırdan farklı çıkmasına yol açabilir.

Bu nedenle programda **“sıfıra eşit”** yerine **“sıfıra yeterince yakın”** kontrolü yapılır:

- $\Delta > \texttt{tol}$  → $\Delta$ pozitif kabul edilir
- $|\Delta| \le \texttt{tol}$ → $\Delta \approx 0$ kabul edilir
- $\Delta < -\texttt{tol}$ → $\Delta$ negatif kabul edilir

### Bu örnekte kullanılan tolerans hesabı

`quadratic.f90` içinde tolerans şu şekilde ölçeklenir:

$$\texttt{tol} = 10^{-12} \cdot \max\left(1,\ |b^2|,\ |4ac|\right)$$

Bu ölçekleme, katsayılar büyüdüğünde toleransın da makul şekilde büyümesini sağlar.

### “$\Delta \approx 0$” örneği

Teoride $x^2 + 2x + 1 = 0$ denklemi için $\Delta = 0$ ve kök $x=-1$’dir.

- Girdi: `1 2 1`
- Beklenen: tek kök $-1$

Yuvarlama hatalarını özellikle tetiklemek için katsayıları küçük değiştirip tekrar deneyebilirsiniz (örneğin `1 2 1.0000000000000002`). Bu tarz durumlarda tolerans kontrolü, yanlışlıkla “iki farklı kök” dalına girilmesini engellemeye yardımcı olur.

## Derleme ve Çalıştırma

```sh
gfortran quadratic.f90 -o quadratic
./quadratic
```

## Kullanım
Program sizden `a b c` değerlerini tek satırda ister.

Örnek giriş:
- `1 5 6`  → kökler: -2 ve -3

## Koddan Önemli Noktalar
- `implicit none` ile güvenli değişken bildirimi
- `real(kind=8)` ve `_8` literal ekleri ile tutarlı hassasiyet
- $\Delta$ değerine göre `if/else if/else` ile dallanma
- Hatalı girdi için `iostat`/`iomsg` kullanımı

## Önerilen Alıştırmalar

1. Programı değiştirip, $\Delta$ için kullanılan `tol` değerini de ekrana yazdırın.
2. `disc == 0.0_8` kullanan “naif” bir kontrol ekleyip, toleranslı kontrol ile farkı gözlemleyin.
3. `a` katsayısı çok küçük (örn. `1.0e-12`) olduğunda sayısal davranış nasıl değişiyor? Deneyip not alın.

İlgili kaynak: `quadratic.f90`
