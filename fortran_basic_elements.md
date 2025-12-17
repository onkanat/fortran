# Temel Elemanlar (Basic Elements)

Fortran ile program yazmaya başlamadan önce temel elemanlar hakkında bilgi sahibi olmak gereklidir.

## Değişkenler (Variable)

Bir Fortran programındaki temel kavram, değişken(variable) kavramıdır.Programdaki değişkenler, cebirsel ifadelerdeki değişkenler gibidir. Değerleri tutmak ve bunları daha sonra matematik ifadeleri yazmak için kullanılır.Fortran farklı türde değişkenlere sahip olmamıza olanak tanır.
Bir değişken aynı anda tek bir değer tutabilir. Değişkene başka bir değer atanır ise, önceki değer üzerine yazılır ve önceki değer kaybolur. 
Değişkenler programın başında tanımlanmalıdır.

**Fortran değişkenleri, çalıştırılabilir ifadelerden önce tanımlanmalıdır. Bu bölüm, değişkenlerin nasıl tanımlandığına dair bir giriş sunmaktadır.**

Her değişkenin bir adı olmalıdır. Değişken adı, bellek konumları olan değişkenlere program tarafından nasıl atıfta bulunulduğunu belirler. Bir değişken adı bir harfle başlamalı, ardından harfler, rakamlar veya bir alt çizgi `_` gelmeli ve 32 karakterden uzun olmamalıdır. Büyük harfler küçük harflerle aynı şekilde ele alınır (örneğin,`AAA` ile `aaa` aynı değişkendir).

**Örneğin, bazı geçerli değişken adları şunlardır:**
    
    x
    today
    next_month
    summation10

## 4.1 Anahtar Kelimeler (Keywords)

Programlamada, anahtar kelime, bir programlama dilinde özel bir anlamı olan bir kelime veya tanımlayıcıdır. Örneğin, önceki bölümdeki "hello world" Fortran programında, "program" kelimesi, bir programın başlangıcını veya başlangıcını belirtmek için kullanıldığı için özel bir anlama sahiptir. Ayrıca, "write" kelimesi, bir çıktı eylemini (örneğin, ekrana gibi bir çıktı aygıtına bilgi yazma) belirtmek için özel bir anlama sahiptir. Bu tür anahtar kelimeler, değişken adları gibi başka hiçbir şey için kullanılamayacak şekilde ayrılmıştır. Yani, "program" veya "write" gibi bir değişken adı kullanılmasına izin verilmez.

```fortran
!Simple Example Program
program first

    write (*,*) "Merhaba Dünya"

end program first
```
## 4.2 Veri Türleri (Data Types)

Fortran, diğer birçok yüksek seviyeli programlama dili gibi, veri manipülasyonunu kolaylaştırmak için çeşitli veri türlerini destekler. En sık kullanılan veri türleri tam sayı (integer) ve kayan noktalı sayılar (floating-point)dır. Diğer veri türleri ise karmaşık sayılar (complex numbers), karakterler (characters) ve mantıksal verilerdir.

Bir Fortran deyiminde, veri hem bir sabit (örneğin, 3.14159, 16, -5.4e-4 gibi gerçek değerler) hem de verileri depolamak için bir bellek konumunu tanımlayan bir değişken adı şeklinde görünebilir.

Aşağıdaki, Fortran 95/2003/2008'de temel veri türleri vardır:

| Tür | Açıklama |
|-------|----------|
| integer | Tam sayı veya tamsayı (kesir olmayan) bir sayıdır; pozitif, negatif ya da sıfır olabilir. |
| real | Gerçek bir sayıya ayarlanabilir. |
| complex | Karmaşık bir sayıya ayarlanabilir. |
| character | Karakter veya karakterlerin bir dizisidir. |
| logical | Sadece .true. veya .false. değerlerine ayarlanabilir. |

Ayrıca türetilmiş türleri ve işaretçileri de olabilir. Bunlar daha gelişmiş programlar için faydalı olabilir ve daha sonraki bölümlerde açıklanmıştır.

### 4.2.1 Tamsayılara (Integer Numbers)

Tamsayı, kesir olmayan tam bir sayıdır; pozitif, negatif veya sıfır olabilir. Örneğin 10, 0, -25 ve 5.148 gibi sayılar tamsayıdır. Tamsayılar insanlar tarafından en tanıdık sayılardır ve matematikte ve bilgisayarlarda önemli bir rol oynarlar. Tüm tamsayılar tam sayıdır, bu yüzden 1 bölü 2 gibi işlemler (1/2) sonucunun tam sayı olması gerektiği için 0 sonucunu verir. Tamsayı bölme işleminde, kesir kısmı yoktur çünkü kesir kısmı budanır.

### 4.2.2 Reel Sayılara (Real Numbers)

Reel sayılar, kesir kısmını da içerir, hatta kesir kısmı 0 olsa bile. Reel sayılar, yani kayan noktalı sayılar, hem rasyonel hem de irrasyonel sayılardan oluşur. İrrasyonel sayılar veya sürekli ondalık açılım olan sayılar örneğin π, √2 ve e'dir. Diğer örnekler ise 1.5, 5.0 ve 3.14159'dür. Fortran 95/2003/2008, 5. olarak 5.0 kabul eder. Bu metindeki tüm örnekler netlik sağlamak için "0." olarak verilmiştir.

### 4.2.3 Karmaşık Sayılara (Complex Numbers)

Matematikte, karmaşık bir sayı reel bir sayı ve sanal bir sayının bileşimidir. a ve b reel sayılardır ve i, i2 = -1.0 özellikli standsart sanal bir birimdir; a + bi formunda yazılabilir. Karmaşık sayılar, sıradan reel sayıları içerir ama ekstra sayılara eklemeyle genişletilmiş bir şekilde tanımlanır ve bu veri türü yaygın olarak kullanılmaz ama gerektiğinde faydalı olabilir. 

### 4.2.4 Karakterlere (Characters)

Karakter, harf, sayısal rakam ya da noktalama işaretidir. Bir string, karakterlerin bir dizisidir. Karakterler ve diziler genellikle tırnak içinde ifade edilir. Örneğin, "Z" büyük harfi bir karakter ve "Hello World" bir dize olarak ifade edilir. Karakterler standart bir format olan ASCII kullanarak gösterilir.

### 4.2.5 Mantıksal Verilere (Logical)
Mantıksal, sadece iki değere sahip olabilir: doğru ya da yanlış. Mantıksal değerler bool (boolean) olarak da bilinir. Fortran'da bu değerler resmi olarak .true. veya .false. olarak tanımlanır, bu değerler mantıksal sabitler olarak da bilinir. Doğru ve yanlış sabitlerinin baş ve sonunda nokta (.) karakteri zorunludur.

## 4.3 Bildirimler (Declarations)

Fortran değişkenleri, yürütülebilir ifadelerden önce bildirilmelidir. Bu bölüm, değişkenlerin nasıl bildirildiğini tanıtmaktadır.

### 4.3.1 Değişkenleri Bildirme (Declaring Variables)

Değişkenleri bildirmek, her bir değişkenin veri türünü resmi olarak tanımlar ve bir bellek lokasyonu ayırmak için kullanılır. Bu işlem, aşağıdaki formatta bir tür bildirimi ifadesi ile yapılır:

```fortran
<type> :: <değişken isimleri listesi>
```

Tür, önceki bölümde belirtilen gibi önceden tanımlanmış veri türlerinden biri olmalıdır (integer, real, complex, character, logical). Bildirimleri programın başında (program ifadesinden sonra) yerleştirilmelidir.

Örnek olarak, bir tamsayı değişkeni tanımlamak için:

```fortran
integer :: today
```

Ek örnekler şunlardır:

```fortran
integer :: today, tomorrow, yesterday
real :: ans2
complex :: z
logical :: answer
character :: myletter
```

Bildirimler herhangi bir sırada girilebilir. Karakter değişkenleri ile ilgili ek bilgiler 11. bölümde verilmiştir.

### 4.3.2 Değişken Aralıkları (Variable Ranges)

Bilgisayar, her bir değişken için kullanılabilecek önceden tanımlanmış bir alan sağlar. Bu doğrudan, temsil edilebilecek sayının boyutunu, ya da aralığını etkiler.

Örneğin, bir tamsayı değeri -2.147.483.648 ile +2.147.483.647 arasında olabilir. Neyse ki bu, çoğu amaç için yeterlidir.

Gerçek sayılar için aralık daha karmaşıktır. Yaklaşık ±1,7×10±38 arasında olup, yaklaşık 7 basamak hassasiyet sağlar.

### 4.3.3 Tür Kontrolü (Type Checking)

Değişken türü bildirimi derleyici tarafından zorunlu kılınır. Örneğin, bir değişken tamsayı olarak bildirildiyse, sadece tamsayı bir değer (tamsayı) bu değişkene atanabilir. 1,75 değerinin bir tamsayı değişkenine atanması, hassasiyet kaybına neden olabilecek sorunlara yol açabilir. Bu sınırlama, farklı türlerin içsel temsillerinin çok farklı ve doğrudan uyumlu olmayan bir yapıya sahip olmasıyla ilgilidir. Derleyici, tip uyuşmazlıklarını bazen fark edebilir ve dönüştürme işlemini (otomatik olarak) gerçekleştirebilir. Bu tür bir otomatik dönüşüm, her zaman açık değildir ve hatalara yol açabilir. Bu nedenle, genellikle kötü bir programlama pratiği kabul edilir.

### 4.3.4 Başlangıç (Initialization)
Bir değişken tanımı yapılırken ve başlangıç değerinin belirlenmesi aynı anda yapılabilir. Bu başlatma işlemi zorunlu değildir, ancak bazı durumlarda kullanışlı olabilir.

Örneğin, bir değişken tanımlayarak ve 15 olarak ayarlayarak:

```fortran
integer :: todaysdate=15
```

Ek örnekler:

```fortran
integer :: todaysday=15, tomorrow=16, yesterday=14
real :: ave = 5.5
```

Değişken ismi ile eşittir işareti arasında boşluk veya yokluk mümkündür. Değişken bildirimi, eşit işaretiyle başlayabilir (başlatma için). Virgüller, aynı satırdaki birden fazla değişken tanımını ayırmak için kullanılır. Tanımlama sırasında tanımlanan değişkenler, daha sonra program içinde istenirse değiştirilebilir.

### 4.3.5 Sabitler (Constants)

Bir sabit, programın çalışması sırasında değişmeyecek olan bir değişkendir. Örneğin, bir program π için bir değişken tanımlamak ve 3,14159 olarak ayarlamak mümkün olabilir. Bir programın π değerini değiştirmesi nadiren gerekebilir. Parametre niteliği, değişkeni sabit olarak tanımlamak, başlangıç değerini ayarlamak ve program çalışırken başlangıç değerinin değiştirilmesine izin vermemek için kullanılır.

Örneğin, aşağıdaki bildirimler:

```fortran
real, parameter :: pi = 3.14159
integer, parameter :: width = 1280
```

pi değişkenini 3,14159 ve width değişkenini 1280 olarak ayarlar ve bu değerlere program çalışırken değiştirilmesini önler.

## 4.4 Yorumlar (Comments)

Daha önce belirtildiği gibi, yorumlar programcı için bilgi sağlar ve derleyici tarafından yok sayılır. Ünlem işareti `(!)` bir yorumu belirtir. Ünlem işaretinden sonra gelen tüm bilgiler derleyici tarafından yok sayılır. Genellikle, yorumlar program hakkında bilgiler içerir. Örneğin, bir yorum son değişiklik tarihini, programcının adını ve güncelleme ayrıntılarını içerebilir. Programlama ödevleri için, yorumlar programcının adını, ödev numarasını ve programın tanımını içerebilir. Yorumlar, kullanılan yaklaşım, formüllerin kaynağı (uygulanabiliyorsa) veya bazı geometrik formüller için pozitif değerlerin kullanılması gibi veri gereksinimleri gibi bilgileri içerebilir. Bu tür referans bilgilerini yorumlamak oldukça teşvik edilir ve gelecekteki bölümlerde ele alınacaktır.

## 4.5 Satır Devamı (Line Continuation)

Bir ifade yeni bir satıra başlamalıdır. Eğer bir ifade çok uzunsa satır sonunda ampersand `(&)` ile devam ettirilebilir. Daha kısa satırlar da bölünerek birkaç satırda devam ettirilebilir, bu da okunabilirlik için daha iyi bir biçimlendirmedir.

Örneğin:
```fortran
A = 174.5 * year &
+ count / 100.0
```

Aşağıdakiyle eşdeğerdir:
```fortran
A = 174.5 * year + count / 100.0
```

Not: '&' işareti ifadenin parçası değildir.

### 4.5.1 Örnek (Example)

Aşağıdaki basit program, program biçimlendirme gerekliliklerini ve değişken bildirimlerini gösterir.

```fortran
! Örnek Program
program example1
implicit none
integer :: radius, diameter
integer :: height=100, width=150
real :: area, perimeter
real :: length = 123.5, distance=413.761
real, parameter :: pi = 3.14159
character(11) :: msg = "Hello World"
write (*,*) "Greeting: ", msg
end program example1
```

Bu örnekte, çeşitli değişkenler tanımlanmıştır (örnek olarak). Program çalıştığında `Greeting: Hello World` yazısı görüntülenir. Sonraki bölümler, değişkenlerin nasıl kullanılacağını ve hesaplamaların nasıl yapıldığını ele alacaktır. Karakter değişkenleriyle ilgili ek bilgiler 11. bölümde verilmiştir.

## 4.6 Bildirimler, Genişletilmiş Boyutlu Değişkenler (Declarations, Extended Size Variables)

Bir Fortran değişkeninde saklanabilecek sayının boyutu ve aralığı sınırlıdır. Daha geniş veya daha büyük aralıklarla değişkenler tanımlamak için özel bildirimler kullanılabilir. Burada sadece tamsayı ve gerçek sayı değişkenleri ele alınmıştır.

### 4.6.1 Tamsayılar (Integers)

Daha önce belirtildiği gibi, tamsayı değerlerin aralığı -2.147.483.648 ile +2.147.483.647 arasındadır. Olası ama çok nadir bir durumda daha büyük bir aralık gerekiyorsa, özel bir bildirimi kullanarak aralığı genişletebilirsiniz. Bu işleç için `kind` belirticisi tamsayı bildiriminde kullanılır.

Örneğin, genişletilmiş bir aralıktaki `bignum` değişkenini tanımlamak için tamsayı bildirimi aşağıdaki gibi olur:

```fortran
integer*8 :: bignum
```

veya

```fortran
integer(kind=8) :: bignum
```

Bu iki eşdeğer bildirim, değişkenler için daha fazla alanı (normalde 4 byte yerine 8 byte) kullanarak daha geniş bir aralık sağlar. `*8` veya `kind=8` ile bildirilen tamsayı değişkenlerinin genişletilmiş aralığı -9.223.372.036.854.775.808 ile 9.223.372.036.854.775.807 arasındadır.

### 4.6.2 Gerçek Sayılar (Real Numbers)

Daha önce belirtildiği gibi, aralık yaklaşık ±1.7×10±38 ve 7 basamak hassasiyet sağlar. Daha fazla hassasiyet gerekiyorsa, `kind` belirticisi kullanılabilir.

Örneğin, genişletilmiş bir aralıktaki `rnum` değişkeni tanımlamak için bildirim şu şekilde olur:

```fortran
real*8 :: rnum
```

veya

```fortran
real(kind=8) :: rnum
```

Bu iki eşdeğer bildirimler, daha büyük bir aralık için değişkenler için daha fazla alanı (normalde 4 byte yerine 8 byte) kullanır. `*8` veya `kind=8` ile bildirilen gerçek sayı değişkenlerinin genişletilmiş hassasiyeti yaklaşık olarak -2.2×10−308 ile +1.8×10+308 arasındadır ve 15 basamak hassasiyetle çok daha büyük bir aralık sağlar.

## 4.7 Alıştırma (Exercises)

Aşağıda bu bölüm baz alınarak bazı alıştırmalar ve proje önerisi yer almaktadır.

### 4.7.1 Alıştırma Sınavı (Quiz Questions)

Aşağıda bazı sınav soruları yer almaktadır:

1) Fortran 95/2003/2008'de beş veri türü nelerdir?
2) Bir Fortran değişkeni adı neyle başlamalıdır?
3) Aşağıdaki sayıların her biri hangi veri türündedir (tamsayı mı, gerçek sayı mı)?
    - 475 ________
    - 19.25 ________
    - 19123 ________
    - 5.0 ________
    - 123.456 ________
4) Aşağıdaki ifadeleri yazınız:
    - `value` değişkenini tamsayı olarak ve `count` değişkenini gerçek sayı olarak tanımlayın.
5) Aşağıdaki ifadeleri yazınız:
    - `rate` değişkenini 7.5 değerine eşit olacak şekilde gerçek sayı olarak tanımlayın.
6) Aşağıdaki ifadeleri yazınız:
    - `e` değişkenini 2.71828183 değerine eşit olacak şekilde sabit gerçek sayı olarak tanımlayın.

### 4.7.2 Önerilen Projeler (Suggested Projects)

Aşağıda bazı önerilen projeler yer almakta:

1) `example1` örneğini yazın, derleyin ve çalıştırın.
2) 1 numaralı örnek programı güncelle (örneğin: 'Hello World' mesajını değil de adınızı görüntüleyecek şekilde).

# 5. İfadeler (Expressions)
Bu bölümde Fortran 95/2003/2008'de ifadelerin nasıl yazılacağı ele alınacaktır. İfadeler, değişkenler (değişken adları) ve sabitler (sabit değerler) kullanılarak oluşturulan matematiksel hesaplamalardır. İfadeler, programın çalışması sırasında hesaplanır ve sonuçlar değişkenlere atanabilir veya doğrudan çıktı için kullanılabilir. Operatörler, ifadelerdeki değişkenler ve sabitler üzerinde işlemler gerçekleştirmek için kullanılır. Fortran 95/2003/2008'de yaygın olarak kullanılan operatörler arasında toplama (+), çıkarma (-), çarpma (*), bölme (/) ve üs alma (**) bulunur. Ayrıca, parantezler kullanılarak işlemlerin önceliği belirlenebilir.


## 5.1 Tam Sayılar (Integer Literals)

En basit öreneği ile tamsayılar:
1
0
-100
32767
+46

### 5.1.2 Gerçek Sayılar (Real Literals)
Gerçek sayılar ondalık nokta içeren sayılardır. Örnekler:
1.0
0.0
-3.14159
2.71828
+0.57721
Gerçek sayılarda `.` ondalık noktayı belirtir. 

### 5.1.2.1 Ayrıca, bilimsel gösterim de kullanılabilir (E-notation)
Büyük veya küçük sayıların göstermi bazen zor olabilir. Bu durumda bilimsel gösterim kullanılır:
1.0E3  ! 1000.0
2.5E-4 ! 0.00025

### 5.1.3 Karmaşık Sayılar (Complex Literals)
Karmaşık sayılar reel ve sanal kısımlardan oluşur. Örnekler:
(1.0, 2.0)   ! 1.0 + 2.0i
(0.0, -3.5)  ! 0.0 - 3.5i
İlk değer reel kısmı, ikinci değer sanal kısmı temsil eder.

### 5.1.4 Karakter Dizileri (Character Literals)
Karakter dizileri, metin verilerini temsil eder. Örnekler:
'Merhaba'
"Dünya"
'Fortran 95'
Karakter ve metin dizileri içinde tek tırnak veya çift tırnak kullanılabilir.
Bunun için boşluk bırakmadan "Merhaba "Bugün" Yağmurlu" yazabilirsiniz.
Bu metin ekranda
`Merhaba "Bugün" Yağmurlu` şeklinde görüntülenir.

### 5.1.5 Mantıksal Değerler (Logical Literals)
Mantıksal değerler doğru veya yanlış durumları temsil eder. Örnekler:
.true.
.false.
Bu değerler genellikle koşullu ifadelerde kullanılır.

## 5.2 Operatörler (Operators)
Fortran 95/2003/2008'de çeşitli operatörler bulunur. İşte bazı yaygın operatörler:
| Operatör | Açıklama           |
|----------|--------------------|
| +        | Toplama            |
| -        | Çıkarma            |
| *        | Çarpma             |
| /        | Bölme              |
| **       | Üs Alma            |
| .AND.    | Mantıksal VE       |
| .OR.     | Mantıksal VEYA     |
| .NOT.    | Mantıksal DEĞİL    |
Operatörler, ifadelerde değişkenler ve sabitler üzerinde işlemler gerçekleştirmek için kullanılır. Örneğin, `a + b` ifadesi `a` ve `b` değişkenlerinin toplamını hesaplar.

### 5.2.1 Atama yada Tanımlama (Assignment Operator)
`real :: x, y, z`ile üç gerçek sayı değişkeni tanımlanır. Daha sonra atama operatörü `=` işareti ile gösterilir. Bu operatör, sağdaki değeri sol taraftaki değişkene atar. Örneğin:
```fortran
x = 5
y = x + 10
```
Bu örnekte, `x` değişkenine 5 değeri atanır ve ardından `y` değişkenine `x`'in değeri ile 10'un toplamı atanır (yani 15).

### 5.2.2 Toplama ve Çıkarma (Addition and Subtraction)
Toplama operatörü `+` iki sayıyı toplar. Örneğin:
```fortran
real :: x, y, z
x = 7.5
y = 2.5 
z = x + y
```
Bu örnekte, `x` ve `y` değişkenlerinin toplamı `z` değişkenine atanır (yani 10.0).

Çıkarma operatörü `-` ise bir sayıyı diğerinden çıkarır. Örneğin:
```fortran
real :: x, y, z
x = 7.5
y = 2.5
z = y - x
``` 
Bu örnekte, `y` değişkeninden `x` değişkeni çıkarılır ve sonuç `z` değişkenine atanır (yani -5.0).

### 5.2.3 Çarpma ve Bölme (Multiplication and Division)
Fortran'da çarpma operatörü `*` iki sayıyı çarpar. Örneğin:
```fortran
real :: x = 7.5, y = 2.5, z 
z = x * y
```
Bu örnekte, `x` ve `y` değişkenlerinin çarpımı `z` değişkenine atanır (yani 18.75).
Bölme operatörü `/` ise bir sayıyı diğerine böler. Örneğin:
```fortran
real :: x = 7.5, y = 2.5, z
z = x / y
```
Bu örnekte, `x` değişkeni `y` değişkenine bölünür ve sonuç `z` değişkenine atanır (yani 3.0).

### 5.2.4 Üs Alma (Exponentiation)
Fortran'da üs alma operatörü `**` bir sayının üssünü hesaplar. Örneğin:
```fortran
real :: x = 2.0, y = 3.0, z
z = x ** y
```
Bu örnekte, `x` değişkeninin `y` değişkeni kadar üssü `z` değişkenine atanır (yani 8.0).

## 5.3 Öncelik ve Parantezler (Precedence and Parentheses)
Fortranda operantların önceliksırası aşşağıdaki tabloda gösterilmiştir:
| Öncelik Sırası | Operatörler          |Operatör Türü       |
|----------------|----------------------|--------------------|
| 1              | -                    | unary -            |
| 2              | **                   | Üs Alma            |
| 3              | *, /                 | Çarpma ve Bölme    |
| 4              | +, -                 | Toplama ve Çıkarma |  

Parantezler, ifadelerdeki işlemlerin önceliğini belirlemek için kullanılır. Parantez içindeki işlemler, parantez dışındaki işlemlerden önce gerçekleştirilir. Soldan sağa doğru değerlendirilir.
Örneğin:
```fortran
real :: x = 2.0, y = 3.0, z = 4.0, result
result = x + y * z
``` 
Bu örnekte, `y * z` işlemi önce gerçekleştirilir ve ardından `x` ile toplanır. Sonuç 14.0 olur.

## 5.4 Dahili Fonksiyonlar (Intrinsic Functions)
Fortran 95/2003/2008, çeşitli dahili fonksiyonlar sağlar. Bu fonksiyonlar, matematiksel hesaplamalar ve veri manipülasyonu için kullanılır. 

### 5.4.1 Matematiksel Fonksiyonlar
Örneğin, `sqrt` fonksiyonu karekök hesaplamak için kullanılır:
```fortran
real :: x = 16.0, result
result = sqrt(x)
```
Bu örnekte, `x` değişkeninin karekökü `result` değişkenine atanır (yani 4.0).

### 4.4.2 Trigonometrik Fonksiyonlar
Trigonometrik fonksiyonlar, açıların sinüs, kosinüs ve tanjantını hesaplamak için kullanılır. Örneğin, `sin` fonksiyonu sinüs hesaplamak için kullanılır:
```fortran
real :: angle = 0.5, result
result = sin(angle)
```
Bu örnekte, `angle` değişkeninin sinüsü `result` değişkenine atanır. (yani yaklaşık 0.4794).
### 5.4.3 Diğer Fonksiyonlar
Dönüşüm fonksiyonları (örneğin, `int`, `real`), mutlak değer fonksiyonu (`abs`) ve logaritma fonksiyonu (`log`) gibi diğer dahili fonksiyonlar da mevcuttur. Örneğin, `abs` fonksiyonu bir sayının mutlak değerini hesaplamak için kullanılır:
```fortran
real :: x = -5.0, result
result = abs(x)
```
Bu örnekte, `x` değişkeninin mutlak değeri `result` değişkenine atanır (yani 5.0).

### 5.4.5 Özet Dahili Fonksiyonlar Tablosu
| Fonksiyon | Açıklama                     |
|-----------|------------------------------|
| sqrt      | Karekök hesaplar             |
| sin       | Sinüs hesaplar   *            |
| cos       | Kosinüs hesaplar  *           |
| tan       | Tanjant hesaplar   *          |
| abs       | Mutlak değer hesaplar        |
| log       | Doğal logaritma hesaplar     |
| exp       | Üs alma (e üzeri x) hesaplar |

***Not:*** Fortran'da trigonometrik fonksiyonlar radyan cinsinden açıları kullanır. Derece cinsinden açıları kullanmak için, açıları radyana dönüştürmeniz gerekir (örneğin, dereceyi π/180 ile çarparak).

## 5.5 Karışık Metinli İfade Örnekleri (Mixed-Type Expression Examples)
Fortran 95/2003/2008'de, farklı veri türlerini içeren ifadeler oluşturabilirsiniz. Ancak, bu tür ifadelerde dikkatli olunmalıdır çünkü tür dönüşümleri otomatik olarak yapılabilir ve beklenmeyen sonuçlara yol açabilir. Örneğin, bir tamsayı ve bir gerçek sayı içeren bir ifade:
```fortran
integer :: a = 5
real :: b = 2.5, result
result = a + b
```
Bu örnekte, `a` tamsayı türündedir ve `b` gerçek türündedir. Fortran, `a`'yı otomatik olarak gerçek sayıya dönüştürür ve ardından toplama işlemi gerçekleştirilir. Sonuç `result` değişkenine atanır (yani 7.5).

## 5.6 Tür Dönüşümü (Type Conversion)
Fortran 95/2003/2008'de tür dönüşümleri bazen derleyici tarafından otomatik olarak yapılabilir; ancak bu otomatik dönüşümler hassasiyet kaybına veya beklenmeyen sonuçlara yol açabilir. Özellikle dikkat edilmesi gereken noktalar:

- real -> integer: int(x) veya otomatik dönüşüm durumda ondalık kısım atılır (truncation toward zero). Yuvarlama yapılmaz; yani 5.7 -> 5, -5.7 -> -5.
- integer -> real: genelde güvenilirdir fakat eğer hedef real tipi düşük hassasiyetliyse (ör. single precision) çok büyük integer değerler tam temsil edilemeyebilir; bu durumda gerçek değer hassasiyeti kaybolabilir.
- real(kind=...) dönüşümleri: farklı kind değerleri arasında dönüşüm yaparken mantıklı bir hassasiyet kontrolü yapın; küçük kademeye indirgeme bilgi kaybına yol açar.

**Yaygın dönüşüm fonksiyonları:**

| Kaynak Türü | Hedef Türü | Dönüşüm Fonksiyonu |
|--------------|------------|---------------------|
| integer      | real       | real()              |
| real         | integer    | int(), nint()       |
| integer      | complex    | cmplx()             |

**Örnek (truncation):**

```fortran
real(kind=8) :: x = 5.7
integer :: y
y = int(x)  ! y = 5 (ondalık kısım atılır)
```

**Öneriler (pratik kurallar):**
- Dönüşümleri açıkça yapın (int(), real(), cmplx(), nint() vb.). Otomatik dönüşümlere güvenmeyin.
- Gerçek sayılarda hassasiyet gerektiğinde real(kind=8) veya uygun kind değerini kullanın.
- Ondalık kısmı yuvarlamak istiyorsanız nint(), floor(), ceiling() gibi fonksiyonları kullanın; int() truncation yapar.
- Çok büyük tamsayılarla çalışırken integer(kind=8) kullanın.

**Kısacası:** Fortran dönüşümleri güçlüdür ancak hassasiyet ve truncation risklerini bilin; gerekli dönüşümleri açıkça yaparak kesin davranış sağlayın.

## 5.7 Örenek Program (Example Program)
Aşağıdaki program, ifadelerin nasıl kullanılacağını gösteren ivmelenme ve hız hesaplama örneğidir.

```fortran
program findvelocity
! Program to calculate the velocity from the
! acceleration and time
! Declare variables
implicit none
real :: velocity, acceleration = 128.0
real :: time = 8.0
! Display initial header
    write (*,*) "Velocity Calculation Program"
    write (*,*)
! Calculate the velocity
    velocity = acceleration * time
    write (*,*) "Velocity = ", velocity
end program findvelocity
```
Bu programda, ivmelenme (acceleration) ve zaman (time) değişkenleri tanımlanır ve ardından hız (velocity) hesaplanır. Sonuç ekrana yazdırılır. Programı derleyip çalıştırarak sonucu görebilirsiniz.

## 5.8 Alıştırma (Exercises)
Aşağıda bu bölüm baz alınarak bazı alıştırmalar ve proje önerisi yer almaktadır.

### 5.8.1 Alıştırma Sınavı (Quiz Questions)
Aşağıda bazı sınav soruları yer almaktadır:
1) Fortran 95/2003/2008'de yaygın olarak kullanılan beş operatör nedir?
2) Aşağıdaki ifadelerin her biri ne anlama gelir?
   - a) x = 10 + 5 * 2
   - b) y = (x + 3) / 2.0
3) Fortran'da parantezlerin kullanımı neden önemlidir?
4) Aşağıdaki ifadeyi yazınız:
   - `a` değişkenini 3.0 ile çarpın ve ardından 5.0 ekleyin, sonucu `b` değişkenine atayın.
5) Dahili fonksiyonlardan üç tanesini ve ne işe yaradıklarını açıklayınız.

### 5.8.2 Önerilen Projeler (Suggested Projects)
Aşağıda bazı önerilen projeler yer almakta:
1) Hız hesaplama programını yazın, derleyin ve çalıştırın.
2) Hız hesaplama programını güncelleyin (örneğin: ivmelenme ve zamanı kullanıcıdan alın).

# 6. Giriş ve Çıkış (Input and Output)
Fortran 95/2003/2008'de giriş ve çıkış işlemleri, programın kullanıcıyla etkileşim kurmasını sağlar. Giriş işlemleri, kullanıcıdan veri almak için kullanılırken, çıkış işlemleri programın sonuçlarını ekrana veya dosyaya yazdırmak için kullanılır. Bu bölümde, Fortran'da giriş ve çıkış işlemlerinin nasıl gerçekleştirileceği ele alınacaktır.

## 6.1 Çıkış İşlemleri (Output Operations)
Fortran'da çıkış işlemleri, `write` ifadesi kullanılarak gerçekleştirilir. `write` ifadesi, belirli bir çıktı birimine veri yazmak için kullanılır. En yaygın kullanılan çıktı birimi, ekrandır (standart çıktı). Aşağıda `write` ifadesinin temel kullanımı gösterilmiştir:
```fortran
write (*,*) "Merhaba Dünya"
```
Bu örnekte, `*` karakteri standart çıktı birimini (ekran) belirtir ve ikinci `*` karakteri format belirticisini ifade eder. Bu ifade, ekrana "Merhaba Dünya" yazdırır.`(*,*)' ifadesi genel amaçlıdır ve basit metin ve değişken çıktıları için uygundur. Free formatlı çıktılar için kullanılır.
Değişkenlerin değerlerini ekrana yazdırmak için `write` ifadesi kullanılabilir. Örneğin:
```fortran
real :: x = 5.75
write (*,*) "Değer x =", x
```
Bu örnekte, `x` değişkeninin değeri ekrana yazdırılır.

## 6.1.1 Print Çıkış (Print Output)
Fortran'da `print` ifadesi de çıkış işlemleri için kullanılabilir. `print` ifadesi, `write` ifadesine benzer şekilde çalışır ancak daha basit bir sözdizimine sahiptir. Aşağıda `print` ifadesinin temel kullanımı gösterilmiştir:
```fortran
print *, "Merhaba Dünya"
```
Bu örnekte, ekrana "Merhaba Dünya" yazdırılır. Değişkenlerin değerlerini ekrana yazdırmak için `print` ifadesi kullanılabilir. Örneğin:
```fortran
real :: y = 3.14
print *, "Değer y =", y
```
Bu örnekte, `y` değişkeninin değeri ekrana yazdırılır.

## 6.2 Giriş İşlemleri (Input Operations)
Fortran'da giriş işlemleri, `read` ifadesi kullanılarak gerçekleştirilir. `read` ifadesi, belirli bir giriş biriminden veri okumak için kullanılır. En yaygın kullanılan giriş birimi, klavyedir (standart giriş). Aşağıda `read` ifadesinin temel kullanımı gösterilmiştir:
```fortran
read (*,*) variable_name
```
Bu örnekte, `*` karakteri standart giriş birimini (klavye) belirtir ve ikinci `*` karakteri format belirticisini ifade eder. Bu ifade, kullanıcıdan veri okumak için kullanılır. Örneğin:
```fortran
real :: z
read (*,*) z
```
Bu örnekte, kullanıcıdan bir gerçek sayı değeri okunur ve `z` değişkenine atanır.

```fortran
integer :: month, day, year
write (*,*) "Lütfen ay, gün ve yıl giriniz (örneğin: 12 25 2023):"
read (*,*) month, day, year
write (*,*) "Girilen tarih: ", month, "/", day, "/", year
```
Bu örnekte, kullanıcıdan ay, gün ve yıl bilgileri alınır ve ardından girilen tarih ekrana yazdırılır.
## 6.3 Formatlı Giriş ve Çıkış (Formatted Input and Output)
Fortran'da formatlı giriş ve çıkış işlemleri, verilerin belirli bir biçimde okunması veya yazdırılması için kullanılır. Formatlı giriş ve çıkış işlemleri, `write` ve `read` ifadelerinde format belirleyicileri kullanılarak gerçekleştirilir. Format belirleyicileri, verilerin nasıl görüntüleneceğini veya okunacağını tanımlar. Aşağıda formatlı çıkış işleminin temel kullanımı gösterilmiştir:
```fortran
write (*,'(A, F6.2)') "Değer x =", x
```
Bu örnekte, `'(A, F6.2)'` format belirleyicisi kullanılarak `x` değişkeninin değeri belirli bir biçimde ekrana yazdırılır. `A` karakter dizisi için, `F6.2` ise gerçek sayı için kullanılır (6 karakter genişliğinde, 2 ondalık basamak). Benzer şekilde, formatlı giriş işlemi de aşağıdaki gibi gerçekleştirilir:
```fortran
read (*,'(F6.2)') x
```
Bu örnekte, `'(F6.2)'` format belirleyicisi kullanılarak kullanıcıdan belirli bir biçimde gerçek sayı değeri okunur ve `x` değişkenine atanır.
### 6.3.1 Format Belirleyicileri (Format Specifiers)
Fortran'da yaygın olarak kullanılan bazı format belirleyicileri şunlardır:
| Belirleyici | Açıklama                     |
|-------------|------------------------------|
| A           | Karakter dizisi               |
| Iw          | Tamsayı (w: genişlik)         |
| Fw.d        | Gerçek sayı (w: genişlik, d: ondalık basamak sayısı) |
| Ew.d        | Bilimsel gösterim (w: genişlik, d: ondalık basamak sayısı) |
| L           | Mantıksal değer                  |
Bu format belirleyicileri, `write` ve `read` ifadelerinde kullanılabilir.

## 6.4 Örnek Program (Example Program)
Takip eden program, kullanıcıdan yarıçap değerini alır ve dairenin alanını hesaplayarak ekrana yazdırır.

```fortran
program circle_area
! Program to calculate the area of a circle
implicit none
real :: radius, area
real, parameter :: pi = 3.14159
! Prompt user for radius
    write (*,*) "Lütfen dairenin yarıçapını giriniz:"
    read (*,*) radius
! Calculate area
    area = pi * radius ** 2
! Display the result
    write (*,'(A, F6.2)') "Dairenin alanı = ", area
end program circle_area
```
Bu programda, kullanıcıdan dairenin yarıçapı alınır, alan hesaplanır ve sonuç belirli bir formatta ekrana yazdırılır.
## 6.5 Alıştırma (Exercises)
Aşağıda bu bölüm baz alınarak bazı alıştırmalar ve proje önerisi yer almaktadır.
### 6.5.1 Alıştırma Sınavı (Quiz Questions)
Aşağıda bazı sınav soruları yer almaktadır:
1) Fortran 95/2003/2008'de çıkış işlemleri için hangi ifadeler kullanılır?
2) Aşağıdaki ifadelerin her biri ne anlama gelir?
   - a) `write (*,*) "Merhaba"`
   - b) `read (*,*) x`
3) Formatlı çıkış işlemi nedir ve neden kullanılır?
4) Aşağıdaki ifadeyi yazınız:
   - Kullanıcıdan bir tamsayı değeri okuyun ve ekrana yazdırın.
5) Aşağıdaki format belirleyicilerini açıklayınız:
   - a) A
   - b) Fw.d
   - c) Iw

### 6.5.2 Önerilen Projeler (Suggested Projects)
Aşağıda bazı önerilen projeler yer almakta:
1) Dairenin alanını hesaplayan programı yazın, derleyin ve çalıştırın.
2) Dairenin alanını hesaplayan programı güncelleyin (örneğin: yarıçapı kullanıcıdan alın ve sonucu formatlı olarak ekrana yazdırın).
3) ivmelenme ve zamanı kullanıcıdan alarak hızı hesaplayan programı yazın, derleyin ve çalıştırın.
4) Fortran kulanarak kullanıcıdan kısa ve uzun kenarları alınan dik üçgenin, tüm geometrik özelliklerini (hipotenüs, çevre, alan,iç açı) hesaplayan programı yazın, derleyin ve çalıştırın.
5) `q = m * c * ΔT` formülünü kullanarak, kullanıcıdan kütle (m), özgül ısı kapasitesi (c) ve sıcaklık değişimi (ΔT) değerlerini alarak, ısı enerjisi (q) hesaplayan programı yazın, derleyin ve çalıştırın.
