# Bölüm 11 ► Karakterler ve Stringler (Characters and Strings)

Bu bölüm, Fortran'da karakter sabitleri, karakter değişkenleri, alt diziler, karşılaştırmalar ve yaygın içsel karakter işlemlerini açıklar. Bölüm sonundaki örnek, metindeki küçük harfleri büyük harfe çeviren bir programdır.

## 11.0 Karakterler ve Stringler (Characters and Strings)

Karakter verileri sabit uzunluklu dizelerle temsil edilir. Varsayılan derleyici ayarları ASCII tablosuna göre çalışır; bu bölümdeki işlemler ASCII temellidir.

## 11.1 Karakter ve String Sabitleri (Character and String Constants)

Karakter sabitleri tek tırnakla (`'A'`) veya çift tırnakla (`"A"`) yazılabilir. Tek karakterlik sabitler de dizelerin özel bir halidir.

```fortran
character :: c1 = 'A'
character(len=5) :: hello = "Hello"
```

## 11.2 Karakter Değişken Bildirimi (Character Variable Declaration)

`character(len=n)` ile sabit uzunluklu, `len=*` ile uzatılmış gösterim, `len=: allocatable` ile çalışma zamanında uzunluk belirlenen değişkenler tanımlanır. Bu projede örnekler sabit uzunluk kullanır.

```fortran
character(len=20) :: user_name
character(len=:), allocatable :: message
```

## 11.3 Karakter Değişken Başlatma (Character Variable Initialization)

Başlatma bildirim sırasında yapılabilir. Uzunluk yetersizse sağdan kesilir; uzunluk büyükse sağa boşluk doldurulur.

```fortran
character(len=8) :: lang = "Fortran"   ! "Fortran "
```

## 11.4 Karakter Sabitleri (Character Constants)

Kaçış gerekmez; tırnak içinde tırnak yazmak için iki kez yazılır: `'It''s ok'`. Boşluk da anlamlı bir karakterdir.

Karakter sabiti tanımlayıp değiştirilmez kılmak için `parameter` kullanılabilir:

```fortran
character(len=7), parameter :: language = "English"
```

Uzunluğu elle saymak yerine derleyicinin saymasını isteyebilirsiniz:

```fortran
character(len=*), parameter :: university = "UNLV"
```

`len=*` derleyiciye sabitin uzunluğunu otomatik hesaplatır ve uygun boyu atar.

## 11.5 Karakter Ataması (Character Assignment)

Atama, karakter değişkenine bir değer vermektir ve `=` ile yapılır. Atama soldan sağa kopyalar; kaynak kısa ise kalan kısım boşlukla doldurulur, uzun ise sağdan kesilir.

```fortran
character(len=9) :: thismonth
thismonth = "September"   ! "September" tam sığar
thismonth = "May"         ! sonuç: "May" + 6 boşluk

character(len=5) :: short
short = "ABCDE"    ! tam sığar
short = "ABCDEFG"  ! "ABCDE" olarak kesilir
```

## 11.6 Karakter İşleçleri (Character Operators)

Birleştirme (concatenation) işleci `//` ile yapılır ve iki (ya da daha fazla) dizeyi uç uca ekler. Literaller veya değişkenler birlikte kullanılabilir.

```fortran
print *, "University of " // "Nevada Las Vegas"   ! literal + literal

character(len=6) :: str1 = "ABCDEF", str2 = "123456"
character(len=12) :: str3
str3 = str1 // str2    ! sonuç: "ABCDEF123456"

character(len=20) :: full
full = "Merhaba" // " " // "Dünya"
```

Not: Formatlarda `nA` gibi tekrar sayıları yer alabilir, ancak esas karakter işleci `//`'dir.

## 11.7 Karakter Alt Dizileri (Character Substrings)

Alt diziler `str(i:j)` ile alınır; sınırlar 1 tabanlıdır ve kapsayıcıdır.

```fortran
character(len=11) :: msg = "Hello World"
print *, msg(1:5)   ! "Hello"
print *, msg(7:)    ! "World"
```

## 11.8 Karakter Karşılaştırmaları (Character Comparisons)

Karakter karşılaştırmaları ASCII sırasına göredir. Standart ilişki operatörleri (`==`, `/=`, `<`, `<=`, `>`, `>=`) basit durumlarda beklendiği gibi çalışır:

```fortran
print *, "A" < "D"        ! .true.
print *, "ABC" == "ABC"   ! .true.
```

Ancak, ASCII sırası nedeniyle bazı karşılaştırmalar şaşırtıcı olabilir:

```fortran
print *, "A"  > "a"    ! .false. (büyük harfler tabloda önce)
print *, "20" < "100"  ! .false. ("2" > "1" leksikografik)
print *, "ABCD" <= "ABC" ! .false. (soldaki daha uzun ve ön eki aynı)
```

Dikkat edilmesi gerekenler:
- Rakamlar `'0'`–`'9'` kendi aralarında mantıklı sıralanır ve harflerden önce gelir.
- `'A'`–`'Z'` kendi aralarında sıralıdır.
- `'a'`–`'z'` kendi aralarında sıralıdır, fakat tüm küçük harfler, tüm büyük harflerden sonra gelir (`"Z" < "a"`).
- Bu nedenle, karışık durumlarda leksikografik/ASCII sırası beklenenden farklı sonuç verebilir; gerektiğinde `iachar/achar` ile özel sıralama uygulanabilir.

## 11.9 İçsel Karakter İşlemleri (Intrinsic Character Operations)

| İşlev | Açıklama |
|-------|----------|
| `ACHAR(i)` | ASCII tablosuna göre `i` (1–127) tamsayısına karşılık gelen karakteri döndürür. |
| `IACHAR(c)` | Karakter `c`'nin ASCII tamsayı değerini döndürür. |
| `LEN(str)` | `str` uzunluğunu (boşluklar dahil) döndürür. |
| `LEN_TRIM(str)` | Sondaki boşlukları hariç tutarak uzunluk döndürür. |
| `TRIM(str)` | Sondaki boşlukları kaldırılmış dize döndürür. |
| `ADJUSTL(str)` | Başa yaslanmış (solda boşluksuz) dize döndürür; boşlukları sağa ekler. |
| `ADJUSTR(str)` | Sağa yaslanmış dize döndürür; boşlukları sola ekler. |

Bu işlevler ASCII tablosunu temel alır (ayrıntı için ek: fortranv3.pdf bölüm 11.9).

## 11.10 Örnek (Example): Küçük Harfleri Büyük Harfe Dönüştürme

Bu örnek, girilen bir dizgedeki küçük harfleri büyük harfe çevirir; diğer karakterler aynı kalır.

### 11.10.1 Problemi Anlama (Understand the Problem)
- Girdi: En fazla 80 karakterlik bir dize.
- İş: Her karakteri kontrol et; `'a'`–`'z'` aralığındaysa büyük harfe çevir.
- Çıkış: Dönüştürülmüş dizeyi ekrana yaz.

### 11.10.2 Algoritmayı Oluşturma (Create the Algorithm)
```fortran
! değişkenleri bildir
! başlık göster
! girdi için istem yap ve oku (80 char)
! sondaki boşlukları temizle; uzunluğu bul
! 1..uzunluk döngüsü:
!   eğer char "a"–"z" arasındaysa
!     iachar ile tamsayıya çevir
!     32 farkını çıkar (ASCII)
!     achar ile geri yaz
! çıktıyı göster
```

### 11.10.3 Programı Uygulama (Implement the Program)

Örnek program için bkz. [`case_converter.md`](./case_converter.md) (kod: [`case_converter.f90`](./case_converter.f90)).

### 11.10.4 Programı Test Etme/Hata Ayıklama (Test/Debug the Program)
- Çıktı metni verilen girdiye göre doğru mu kontrol edin.
- Örnek beklenen çıktı:
  - Girdi: `Hello World!?`
  - Çıktı: `HELLO WORLD!?`
- Farklı girdilerle (rakam, noktalama, karışık harf) deneyip sadece küçük harflerin değiştiğini doğrulayın.

## 11.11 Alıştırmalar (Exercises)

### 11.11.1 Sınav Soruları (Quiz Questions)
1) `msg` adlı, "Hello World!" içerecek karakter değişkeni bildirimi nedir?
2) Aşağıdaki karşılaştırmaların hangileri doğrudur, hangileri yanlıştır?
   - `"D" > "c"`
   - `"100" < "20"`
   - `"Da" > "cA"`
   - `"20" < "10"`
   - `"d" > "C"`
   - `"20" < "100"`
   - `"ABBC" <= "ABCD"`

### 11.11.2 Önerilen Projeler (Suggested Projects)
1) Küçükten büyüğe dönüştürme örneğini yazın, derleyin, farklı girdilerle test edin.
2) Programı büyükten küçüğe dönüştürecek şekilde genişletin; test edin.
3) Bir dizedeki ünlüleri (`a, e, i, o, u`) sayan program yazın; küçük/büyük harfi birlikte sayın.
4) 5 dize okuyup alfabetik sıralama ile yazdıran program yazın; rakamlı ve karışık harfli girdilerle test edin.
