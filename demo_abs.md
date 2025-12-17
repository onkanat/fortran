# `ABS` Fonksiyonu

`ABS` fonksiyonu, bir sayının mutlak değerini döndüren temel bir Fortran içsel (intrinsic) fonksiyonudur. Tamsayı (`INTEGER`), gerçek (`REAL`) ve karmaşık (`COMPLEX`) sayı türleriyle çalışabilir.

## Kod Açıklaması

`demo_abs.f90` dosyasındaki kod, `ABS` fonksiyonunun çeşitli kullanımlarını göstermektedir.

```fortran
program demo_abs
implicit none
integer,parameter :: dp=kind(0.0d0)

integer           :: i = -1
real              :: x = -1.0
complex           :: z = (-3.0,-4.0)
doubleprecision   :: rr = -45.78_dp

! ... format tanımlamaları ...

  ! Temel kullanım
    write(*, frmt)  'integer         ',  i, abs(i)
    write(*, frmt)  'real            ',  x, abs(x)
    write(*, frmt)  'doubleprecision ', rr, abs(rr)
    write(*, frmtc) 'complex         ',  z, abs(z)
```

### Temel Kullanım

- **`integer`**, **`real`**, **`doubleprecision`**: Bu türler için `ABS`, sayının pozitif değerini döndürür.
- **`complex`**: Karmaşık bir sayı `z = (a, b)` için `abs(z)`, sayının büyüklüğünü (magnitude) veya orijine olan uzaklığını döndürür. Bu değer `sqrt(a**2 + b**2)` formülüyle hesaplanır. Örnekte `z = (-3.0, -4.0)` için `abs(z)` sonucu `sqrt((-3.0)**2 + (-4.0)**2) = sqrt(9.0 + 16.0) = sqrt(25.0) = 5.0` olur.

---

```fortran
  ! Değer aralığı (range) testi
    write(*, *) 'abs range test : ', abs(huge(0)), abs(-huge(0))
    write(*, *) 'abs range test : ', abs(huge(0.0)), abs(-huge(0.0))
    write(*, *) 'abs range test : ', abs(tiny(0.0)), abs(-tiny(0.0))
```
### Değer Aralığı

`ABS` fonksiyonu, pozitif değeri aynı tür ve tür (kind) parametresi ile temsil edilebilen herhangi bir değerin mutlak değerini alabilir. `huge()` (en büyük temsil edilebilir sayı) ve `tiny()` (en küçük pozitif temsil edilebilir sayı) gibi sınır değerlerle de sorunsuz çalışır.

---

```fortran
  ! Elemental olma özelliği
    write(*, g) ' abs is elemental:', abs([20,  0,  -1,  -3,  100])
```
### Elemental Olma Özelliği

`ABS` fonksiyonu **elemental**'dır. Bu, bir diziye (array) uygulandığında, dizinin her bir elemanına ayrı ayrı uygulanacağı anlamına gelir. Sonuç, her elemanın mutlak değerini içeren yeni bir dizidir.

---

```fortran
  ! COMPLEX girdi REAL çıktı üretir
    write(*, g)' complex input produces real output', &
    & abs(cmplx(30.0_dp,40.0_dp,kind=dp))
```
### Karmaşık Girdi -> Gerçek Çıktı

`ABS` fonksiyonuna karmaşık bir sayı verildiğinde, döndürdüğü sonuç her zaman gerçek (`REAL`) bir sayıdır. Döndürülen gerçek sayının türü (kind), orijinal karmaşık sayının türüyle aynıdır.

---

```fortran
  ! Karmaşık sayılar için orijine uzaklık
    write(*, g) ' distance of (', z, ') from zero is', abs( z )
    write(*, g) ' so beware of overflow with complex values'
    !write(*, g) abs(cmplx( huge(0.0), huge(0.0) ))
    write(*, g) ' because the biggest default real is',huge(0.0)
```
### Orijine Uzaklık ve Taşma (Overflow) Riski

Karmaşık sayılar için `ABS` sonucunun geometrik anlamı, sayının karmaşık düzlemde orijine `<0,0>` olan uzaklığıdır.

Bu hesaplama sırasında dikkatli olmak gerekir. Çok büyük bileşenlere sahip karmaşık bir sayının mutlak değeri hesaplanırken (`sqrt(a**2 + b**2)`) ara hesaplama olan `a**2 + b**2` işlemi, temsil edilebilir en büyük sayıdan daha büyük bir sonuç üretebilir ve **taşma (overflow)** hatasına neden olabilir.
