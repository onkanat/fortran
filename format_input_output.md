# Bölüm 10 ► Formatlı Giriş/Çıkış

Bu bölüm, Fortran'da formatlı giriş ve çıkış işlemlerini detaylı olarak açıklar. Format belirleyicilerinin kullanımı, farklı veri türlerinin nasıl biçimlendirileceği ve gelişmiş I/O teknikleri hakkında bilgi içerir.

## 10.0 Formatlı Giriş/Çıkış

Fortran, verilerin nasıl görüntüleneceği veya okunacağını kontrol etmeye izin vermek için bir FORMAT ifadesi kullanır. Bu, çok belirli giriş veya çıkış gerektiğinde kullanışlıdır. Örneğin, para rakamlarının görüntülenmesi tipik olarak tam olarak iki ondalık basamak gerektirir. Her veri türü için format belirleyicileri vardır; tamsayı, gerçek sayı, karakter, mantıksal ve karmaşık sayı.

## 10.1 Format

Format belirleyicileri, virgüllerle ayrılmış olarak, bir dize sabiti olarak bir çift parantez içinde bulunur. Format tanımlamanın birden çok yolu vardır. Ancak, en kolay, en doğrudan yönteme odaklanacağız. Format belirleyicisi, okuma veya yazma ifadelerindeki ikinci "*" yerine geçecektir. Örneğin:

```fortran
read (*,'(<format belirleyicileri>)') <değişkenler>
write (*,'(<format belirleyicileri>)') <değişkenler/ifadeler>
```

Aşağıdaki bölümler format belirleyicileri için seçenekleri açıklar.

## 10.2 Format Belirleyicileri

Format belirleyicileri, sisteme girişin veya çıkışın tam olarak nasıl ele alınması gerektiğini söyler. Okunan veya yazılan her değer bir miktar boşluk gerektirir. Örneğin, dört basamaklı bir tamsayı yazdırmak için en az dört boşluk veya pozisyon gerekir. Bu nedenle, kullanılacak pozisyon sayısı belirleyicinin önemli bir parçasıdır.

Aşağıdaki sembol konvansiyonu kullanılır:
- w → kullanılacak pozisyon sayısı
- m → kullanılacak minimum pozisyon sayısı
- d → ondalık noktanın sağındaki basamak sayısı
- n → sayı veya miktar
- c → sütun numarası
- r → tekrar sayısı

En yaygın kullanılan format belirleyicilerinin özeti aşağıdadır:

| Açıklama | Belirleyici |
|----------|-------------|
| Tamsayılar | rIw veya rIw.m |
| Gerçek Sayılar | rFw.d |
| Mantıksal | rLw |
| Karakterler | rA veya rAw |
| Yatay Konumlandırma (boşluk) | nX |
| Yatay Konumlandırma (sütun) | Tc |
| Dikey Boşluk | n/ |

Ek olarak, her belirleyici veya belirleyici grubu, başına bir tekrar sayısı getirilerek tekrarlanabilir. Karmaşık sayılar için format belirleyicileri sonraki bölümlerde ele alınacaktır.

## 10.3 Tamsayı Format Belirleyicisi

Tamsayı format belirleyicisi `rIw` veya `rIw.m`, sisteme bir tamsayı değişkenini okumak veya yazmak için tam olarak kaç pozisyon kullanılması gerektiğini söylemek için kullanılır. `w` genişliktir veya kullanılan toplam yer sayısıdır. Sayı negatifse, işaret bir yer kullanır. `m` isteğe bağlıdır ve gösterilecek minimum basamak sayısını ayarlamak için kullanılabilir, minimum basamak sayısını göstermek için gerekirse baştaki sıfırları gösterecektir. `r`, format belirleyicisinin kaç kez tekrarlanması gerektiğidir.

`(i6)` formatı şöyle görünür:

```
x x x x x x
← w →
```

Örneğin, şu bildirimler verildiğinde:

```fortran
integer :: num1=42, num2=123, num3=4567
```

num1 değişkenindeki değeri başında veya sonunda boşluk olmadan göstermek için aşağıdaki yazma ifadesi kullanılabilir:

```fortran
write (*,'(i2)') num1
```

Bu "42" gösterecektir.

Birden fazla değişken gösterilebilir. Örneğin, num1 ve num2 değişkenlerindeki değerleri, başında veya sonunda boşluk olmadan göstermek için:

```fortran
write (*,'(i2,i3)') num1, num2
```

Bu iki farklı değer arasında boşluk olmadan "42123" gösterecektir. Ancak:

```fortran
write (*,'(i2,i4)') num1, num2
```

değerler arasında bir boşlukla "42 123" gösterecektir. Ayrıca:

```fortran
write (*,'(i5,i5,i5)') num1, num2, num3
```

her değişkenin 5 boşluk kullandığı " 42 123 4567" gösterecektir. Ve son olarak:

```fortran
write (*,'(i6.4)') num1
```

" 0042" gösterecektir.

## 10.4 Gerçek Sayı Format Belirleyicisi

Gerçek sayı format belirleyicisi `rFw.d`, sisteme bir gerçek sayı değişkenini okumak veya yazmak için tam olarak kaç pozisyon kullanılması gerektiğini söylemek için kullanılır. `w` genişliktir veya kullanılan toplam yer sayısıdır, ondalık nokta dahil. Sayı negatifse, işaret bir yer kullanır. `d`, ondalık noktanın sonunda kaç basamağın görüntüleneceğidir, ondalık nokta sayılmaz. `r`, format belirleyicisinin kaç kez tekrarlanması gerektiğidir.

`(f6.2)` formatı şöyle görünür:

```
x x x . x x
← d →
← w →
```

Örneğin, şu bildirimler verildiğinde:

```fortran
real :: var1=4.5, var2=12.0, var3=2145.5713
```

var1 değişkenindeki değeri başında veya sonunda boşluk olmadan göstermek için aşağıdaki yazma ifadesi kullanılabilir:

```fortran
write (*,'(f3.1)') var1
```

Bu başında boşluk olmadan "4.5" gösterecektir. Birden fazla değişken gösterilebilir. Örneğin, var1 ve var2 değişkenlerindeki değerleri göstermek için:

```fortran
write (*,'(f5.2,f8.3)') var1, var2
```

Bu " 4.50 12.000" gösterecektir. Üç değişkenli (var1, var2 ve var3) başka bir örnek şöyledir:

```fortran
write (*,'(f10.4,f10.4,f10.4)') var1, var2, var3
```

Bu her değişkenin 10 boşluk kullandığı ve her birinin ondalık noktadan sonra tam olarak 4 basamak olduğu " 4.5000 12.0000 2145.5713" gösterecektir.

Bir sayıyı istediğiniz kadar pozisyonla yazdırabilirsek de, bu sadece giriş/çıkış biçimlendirmesidir. Pozisyon sayısı veya boyut, o sayının hassasiyeti (yani, anlamlı basamak sayısı) değildir. Gerçek sayıların varsayılan hassasiyeti yaklaşık yedi anlamlı basamaktır. Bu, gerçek sayıların hassasiyetidir. Ancak, gerçek bir sayıyı 50 pozisyonda, bunun 25'i kesirli kısım için olacak şekilde yazdırabiliriz. Bu sadece görünüşünü tanımlamanın bir yoludur ve gerçek sayıların hassasiyetini değiştirmez.

## 10.5 Yatay Konumlandırma Belirleyicileri

Yatay konumlandırma belirleyicileri, `nX` ve `Tc`, gerektiğinde belirli yatay boşluk veya yerleşim sağlamak için kullanılır. `nX` belirleyicisi, n boşluk eklemek için kullanılır. `Tc` belirleyicisi, doğrudan belirtilen sütuna (c) gitmek için kullanılır.

Örneğin:

```fortran
write (*,'(a,2x,a,t20,a)') "X", "Y", "Z"
```

aşağıdakileri gösterecektir:

```
X Y Z
```

Başlangıç X ve Y iki boşlukla ayrılır. Son Z, 20. sütuna yerleştirilir.

## 10.6 Mantıksal Format Belirleyicisi

Mantıksal format belirleyicisi `rLw`, sisteme bir mantıksal değişkenini okumak veya yazmak için tam olarak kaç pozisyon kullanılması gerektiğini söylemek için kullanılır. `w` genişliktir veya kullanılan toplam yer sayısıdır. `r`, format belirleyicisinin kaç kez tekrarlanması gerektiğidir. Bir mantıksal değişken sadece mantıksal sabitler `.true.` veya `.false.` ile ayarlanabildiği için, genişlik mantıksal sabitlerin kaç karakterinin okunacağını veya gösterileceğini belirleyecektir.

Örneğin, şu bildirimler verildiğinde:

```fortran
logical :: door_open=.true., window_open=.false.
```

door_open ve window_open mantıksal değişkenlerindeki değerleri, başında veya sonunda boşluk olmadan göstermek için aşağıdaki yazma ifadesi kullanılabilir. Sadece bir T veya F gösterileceği not edilmelidir. Aşağıdaki yazma ifadesi:

```fortran
write (*,'(l1,1x,l1)') door_open, window_open
```

"T F" gösterecektir. Not, `l1` formatı küçük harf L ve sayı 1'dir.

Boyut veya genişlik gerektiği gibi ayarlanabilir. Örneğin, aşağıdaki yazma ifadesi:

```fortran
write (*,'(l3,2x,l3)') door_open, window_open
```

" T F" gösterecektir, bu toplam 8 karakter gösterecektir; sağa dayalı L3'ten iki boşluk ve bir T (__T), ardından 2X'ten 2 boşluk (__), ve sonra L3'ten iki boşluk ve bir F (__F).

## 10.7 Karakter Format Belirleyicisi

Karakter format belirleyicisi `rAw`, sisteme bir karakter değişkenini okumak veya yazmak için tam olarak kaç pozisyon kullanılması gerektiğini söylemek için kullanılır. `w` genişliktir veya kullanılan toplam yer sayısıdır. Genişlik belirtilmezse, dizenin mevcut uzunluğu kullanılır. `r`, format belirleyicisinin kaç kez tekrarlanması gerektiğidir.

`(a6)` formatı şöyle görünür:

```
c c c c c c
← w →
```

Örneğin, şu bildirimler verildiğinde:

```fortran
character(len=11) :: msg = "Hello World"
```

msg değişkenindeki dizeyi başında veya sonunda boşluk olmadan göstermek için aşağıdaki yazma ifadesi kullanılabilir. Aşağıdaki yazma ifadesi:

```fortran
write (*,'(a11)') msg
```

"Hello World" gösterecektir. Karakter format belirleyicisi kullanılırken sayı gerekli değildir. Örneğin, şu ifade:

```fortran
write (*,'(a)') msg
```

aynı "Hello World" dizesini gösterecektir. Birden fazla değişken veya dize gösterilebilir. Ayrıca, sayı dizenin bir kısmını göstermek için kullanılabilir. Örneğin, msg değişkenindeki dizeyi ve "Goodbye cruel world" dizesini göstermek için:

```fortran
write (*,'(a9,2x,a)') msg, "Goodbye cruel world"
```

Bu ekrana "Hello Wor Goodbye cruel world" gösterecektir. İlk dize değişkeni olan msg için, toplam 11 karakterden sadece ilk 9 karakterin gösterildiğine dikkat edin, çünkü A9 formatı kullanıldı.

## 10.8 Advance Maddesi

Advance maddesi, bilgisayara imleci bir sonraki satıra geçip geçmeyeceğini söyler. Olası değerler "yes" ve "no"dur. Advance maddesi dahil edilmezse, varsayılan değer "yes"dir.

Bu madde, kullanıcı girişi için istemde bulunurken kullanışlıdır, böylece giriş istem ile aynı satırda girilebilir. Advance maddesi kullanılırken, serbest format (*) izin verilmez. Bir format dahil edilmelidir.

Örneğin, önceki bölümden period programı aşağıdaki ifadeleri içeriyordu:

```fortran
! kullanıcıdan n değerini iste ve oku
write (*,'(a)') "Enter count to sum: "
read (*,*) n
```

Bu, yürütüldüğünde, giriş istemden sonraki satıra girilir:

```
c:\mydir> sums
Example Program
Difference between sum of squares
and square of sums
Enter count to sum:
10
Difference: 2640
```

Advance maddesi "no" ayarıyla kullanıldığında, şöyle ki:

```fortran
! kullanıcıdan n değerini iste ve oku
write (*,'(a)', advance="no") "Enter count to sum: "
read (*,*) n
```

Sonuçta yürütme şöyle olacaktır:

```
c:\mydir> sums
Example Program
Difference between sum of squares
and square of sums
Enter count to sum: 10
Difference: 2640
```

Bu, girişin istem ile aynı satırda girilmesine izin verir.

Aynı örneğin Türkçe sürümü şöyle olacaktır:

```fortran
! kullanıcıdan n değerini iste ve oku
write (*,'(a)', advance="no") "Toplanacak sayı miktarını girin: "
read (*,*) n
```

Sonuçta yürütme şöyle olacaktır:

```
c:\mydir> sums
Örnek Program
Karelerin toplamı ile
toplamların karesi arasındaki fark
Toplanacak sayı miktarını girin: 10
Fark: 2640
```

Bu, girişin istem ile aynı satırda girilmesine izin verir.

## 10.9 Örnek

Bu örnek, kullanıcıdan bir tarih okuyacak (ay, gün ve yıl, aynı satırda), o tarihin (ay/gün/yıl için) haftanın gününü belirleyecek. Ardından program, orijinal giriş tarihini (sayısal form) ve formatlı tarihi gösterecek. Orijinal giriş tarihi, baştaki sıfırlar dahil (örneğin, 01/01/2010) ilgili alanlarla gösterilecek.

### 10.9.1 Problemi Anlama

Bu problem için, kullanıcıdan tarihin üç sayısını okuyacağız. Tarih bilgisinin doğrulanması bir egzersiz olarak bırakılmıştır.

Belirli bir tarihin hangi güne geldiğini hesaplamak için aşağıdaki algoritma kullanılabilir (bölümler tamsayı bölümleridir):

```
a = (14 - ay) / 12
y = yil - a
m = ay + 12*a - 2
gun_sayisi = [ gun + y + y/4 - y/100 + y/400 + (31*m/12) ] mod 7
```

gun_sayisi değeri Pazar için 0, Pazartesi için 1, Salı için 2, vb.

Not: Değişken adları Türkçe anlamlarını korurken ASCII karakterlerle (yil, gun, gun_sayisi) yazılmıştır; Fortran tanımlayıcılarında aksanlı karakterlerden kaçınmak taşınabilirliği artırır.

### 10.9.2 Algoritmayı Oluşturma

Bu problem için, önce tarihi okumamız gerekecek. Girilen tarihin doğrulanması ve hata kontrolü bir egzersiz olarak bırakılmıştır. Ardından, orijinal giriş tarihi, uygun şekilde biçimlendirilmiş sayısal formda gösterilebilir. Bir tarih için bu, ay için iki basamak, bir "/", gün için iki basamak, bir "/" ve yıl için dört basamak anlamına gelir. Gün sadece tek basamaklı olduğunda, örneğin 5, "05" göstermek adettendir, bu yüzden program bunun gerçekleşmesini sağlayacaktır.

```fortran
! değişkenleri bildir
! tamsayı -> ay, gün, yıl
! tamsayı -> a, y, m, gun_sayisi (hesaplamalar için)
! başlık göster
! ay, gün ve yıl için istemde bulun
! ay, gün ve yıl oku
! formatlı sayısal ay/gün/yıl göster
```

Ardından program, haftanın gününü hesaplayabilir (formüle dayalı olarak) ve ortaya çıkan sayıyı (0-6) bir tarih dizgesine dönüştürebilir ve sonucu gösterebilir.

```fortran
! haftanın gününü hesapla
! haftanın gününü (0-6) dizgeye dönüştür
! ayı (1-12) dizgeye dönüştür
! gün, ay ve yıl için formatlı dize göster
```

Kolaylık olması açısından, adımlar program yorumları olarak yazılmıştır.

### 10.9.3 Programı Uygulama

Algoritmaya dayalı olarak, aşağıdaki program oluşturulabilir.

```fortran
program date_formatter
    implicit none
    integer :: month, day, year
    integer :: a, m, y, d
    character(len=9) :: month_name, day_of_week
    ! ----------
    ! başlık göster
    write (*,*) "Tarih Biçimlendirme Örneği"
    ! ay, gün ve yıl için istemde bulun
    write (*,'(a)', advance="no") "Tarih (ay, gün, yıl): "
    ! ay, gün ve yıl oku
    read (*,*) month, day, year
    ! ----------
    ! formatlı sayısal ay/gün/yıl göster
    write (*,*) "----------------------------------------"
    write (*,*) "Giriş Tarihi: "
    write (*,'(5x, i2.2, a, i2.2, a, i4)') month, "/", &
             day, "/", year
    ! ----------
    ! haftanın gününü hesapla
    a = (14 - month) / 12
    y = year - a
    m = month + 12 * a - 2
    d = mod((day + y + y/4 - y/100 + y/400 + (31*m/12)), 7)
    ! ----------
    ! haftanın günü tamsayısını haftanın günü dizesine dönüştür
    select case (d)
    case (0)
        day_of_week = "Pazar    "
    case (1)
        day_of_week = "Pazartesi"
    case (2)
        day_of_week = "Salı     "
    case (3)
        day_of_week = "Çarşamba"
    case (4)
        day_of_week = "Perşembe "
    case (5)
        day_of_week = "Cuma     "
    case (6)
        day_of_week = "Cumartesi"
    end select
    ! ----------
    ! ayı (1-12) dizeye dönüştür
    select case (month)
    case (1)
        month_name = "Ocak     "
    case (2)
        month_name = "Şubat    "
    case (3)
        month_name = "Mart     "
    case (4)
        month_name = "Nisan    "
    case (5)
        month_name = "Mayıs    "
    case (6)
        month_name = "Haziran  "
    case (7)
        month_name = "Temmuz   "
    case (8)
        month_name = "Ağustos  "
    case (9)
        month_name = "Eylül    "
    case (10)
        month_name = "Ekim     "
    case (11)
        month_name = "Kasım    "
    case (12)
        month_name = "Aralık   "
    end select
    ! ----------
    ! gün, ay ve yıl için formatlı dize göster
    write (*,'(/a)') "Biçimlendirilmiş Tarih:"
    write (*,'(5x, a, a, a, 1x, i2.2, a, i4/)') &
             trim(day_of_week), ", ", trim(month_name), &
             day, ", ", year
end program date_formatter
```

**Derleme ve Çalıştırma:**
```bash
gfortran date_formatter.f90 -o date_formatter
./date_formatter
```

Boşluk ve girintiler gerekli değildir, ancak programın daha okunabilir olmasına yardımcı olur. `trim()` içsel işlevi, giriş dizesindeki tüm sonundaki boşlukları kaldırır. Karakter veri türlerinin ele alınması hakkında ek bilgiler aşağıdaki bölümde verilmiştir.

### 10.9.4 Programı Test Etme/Hata Ayıklama

Bu problem için test, çıkış biçimlendirmesinin doğru olduğundan emin olmak olacaktır. Girişte hata kontrolü olmadığı için, sadece doğru tarihler girilmelidir. Programı bir dizi farklı giriş değeri üzerinde test edin ve bu giriş değerleri için çıktının doğru olduğunu doğrulayın.

## 10.10 Alıştırmalar

Bu bölüme dayalı bazı sınav soruları ve proje önerileri aşağıdadır.

### 10.10.1 Sınav Soruları

Aşağıda bazı sınav soruları yer almaktadır.

1) Aşağıdakilerden her biri için format belirleyicisi nedir:
   a) tamsayı değerler
   b) gerçek sayı değerler
   c) mantıksal değerler
   d) yatay boşluk (yani boşluklar)
   e) yeni bir satır
   f) karakterler/dizeler

2) Aşağıdaki kod parçasının çıktısını açıklayın (her biri 1 puan):
   Not, boşlukları _ (alt çizgi) karakteriyle gösterin.
   ```fortran
   write (*,'(a5)') "Hello World"
   write (*,'(a)') "Hello World"
   ```

3) Aşağıdaki kod parçasının çıktısını açıklayın (3 puan):
   Not, boşlukları _ (alt çizgi) karakteriyle gösterin.
   ```fortran
   integer :: number = 5
   write (*,'(i5.3)') number
   ```

4) 0 ile 999 arasında bir değer içeren tamsayı değişkeni num1'i çıkarmak için yazma ifadesi ve format belirleyicisi nedir (sağa dayalı, baştaki sıfırlar yok, ekstra boşluk yok)?

5) 3.14159 ile başlatılan gerçek sayı değerini pi'yi çıkarmak için yazma ifadesi ve format belirleyicisi nedir (sağa dayalı, ekstra boşluk yok)?

6) "Programming" ve "Is Fun!" ifadelerini iki farklı satıra çıkarmak için tek yazma ifadesi ve format belirleyicisi nedir?

7) "Enter Number:" ifadesini çıkarmak ve imleci geçerli satırda tutmak için tek yazma ifadesi ve format belirleyicisi nedir?

### 10.10.2 Önerilen Projeler

Aşağıda bazı önerilen projeler yer almaktadır.

1) Tarih biçimlendirme program örneğini yazın, derleyin ve programı yürütün. Programı bir dizi farklı giriş değeri üzerinde test edin ve bu giriş değerleri için çıktının doğru olduğunu doğrulayın.

2) Tarih biçimlendirme programını, girilen tarihte tam hata kontrolü yapacak şekilde güncelleyin. Yani, program ay için uygun değerleri (1 ile 12 arasında), tarih için uygun değerleri (1 ile 31 arasında), özel ay için geçerli bir tarihin kontrolü dahil, ve yıl değerinin 1970 ve 3000 (dahil) arasında olduğunu kontrol etmelidir. Örneğin, Nisan 31 geçerli bir tarih değildir. Ayrıca, program, o yıl için Şubat'ın 28 veya 29 gün olup olmadığını görmek için artık yıl kontrolü yapmalıdır. Programı bir dizi farklı giriş değeri üzerinde test edin ve bu giriş değerleri için çıktının doğru olduğunu doğrulayın.

3) Bir amortisman planı gösteren bir Fortran programı yazın. Program, kredi tutarını, yıllık faiz oranını ve kredi süresini ay olarak (tek bir satırdan) okumalıdır.

Aylık ödemeyi hesaplama formülü şöyledir:

```
payment = amount ∗ ( irate ∗ (1+ irate)^term ) / ( (1+irate)^term − 1 )
```

Not, formüldeki yıllık faiz oranı, irate, bir aylık orana dönüştürülmelidir (12'ye bölünür) ve ardından 100'e bölünür (yüzdeden dönüştürmek için). Zaman süresi boyunca, her aylık ödemenin bir kısmı faiz ödemek için ve bir kısmı kalan bakiyeyi azaltmak için kullanılacaktır. Aylık faiz tutarı, aylık faiz oranı ile kalan bakiyenin çarpılmasıyla hesaplanabilir. Tutarlar sadece kuruş için iki basamakla hizalanmalıdır. Ödeme numarası üç basamak göstermelidir, gerekirse baştaki sıfırlar dahil. Programı bir dizi farklı giriş değeri üzerinde test edin ve bu giriş değerleri için çıktının doğru olduğunu doğrulayın.

Çıktı, ödeme numarası, aylık ödeme, ödenen anapara, ödenen faiz ve kalan bakiye için uygun başlıklar ve hizalanmış ve biçimlendirilmiş sütunlardan oluşacaktır. Her sütunun altında bir toplam görünecektir.

Kredi tutarları 250.000$'ı geçmemelidir ve maksimum kredi süresi 360 ayı geçmemelidir. Üç giriş değişkeninin tek bir satırda biçimlendirildiği gereksinimi izlediğinizden emin olun.

**Derleme ve Çalıştırma:**
```bash
gfortran amortisman_programi.f90 -o amortisman_programi
./amortisman_programi
```

4) Bileşik faiz hesaplayan ve gösteren bir Fortran programı yazın. Program, başlangıç anapara tutarını, faiz oranı yüzdesini ve süreyi (yıl sayısı) okumalıdır. Program, girişin özetini ve yıllık bileşik faizi göstermelidir. Biçimlendirme için örnek çıktıya bakın.

Bileşik faiz formülü şöyledir:

```
value = principal( 1+interest )^year
```

Not, kullanıcıdan okunan faiz oranı yüzdesi bir sayıya dönüştürülmelidir (yani 100'e bölünür). Çıktı, örnek çıktıya benzer bir şekilde biçimlendirilmelidir. Bu, dolar tutarlarının uygun iki ondalık nokta ile gösterilmesini sağlamayı içerir. Programı bir dizi farklı giriş değeri üzerinde test edin ve bu giriş değerleri için çıktının doğru olduğunu doğrulayın.

**Derleme ve Çalıştırma:**
```bash
gfortran bilesik_faiz.f90 -o bilesik_faiz
./bilesik_faiz
```