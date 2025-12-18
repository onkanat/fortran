# 7.1 Fortran Program Geliştirme Metodolojisi (Fortran Program Development Methodology)

Program yazma veya geliştirme, net bir metodoloji izlediğinde daha kolaydır. Metodolojideki ana adımlar şunlardır:

- Problemi Anlama
- Algoritma Oluşturma
- Programı Uygulama
- Programı Test/Debug Etme

Bu süreci ayrıntılı olarak göstermek için, bu adımlar basit bir problem olan bir sarkacın periyodunu
hesaplama ve görüntüleme problemine uygulanacaktır.
Daha sonraki bölümlerde sunulan ek örnekler, bu metodoloji kullanılarak açıklanacak ve sunulacaktır.

## 7.1 Problemi Anlama
Bir çözüm oluşturmaya çalışmadan önce, problemi anlamak önemlidir. Problemi tam olarak anlamak,
hataları azaltmaya yardımcı olabilir. İlk adım, hangi girdinin gerekli olduğunu ve programın
hangi bilgileri üretmesinin beklendiğini anlamaktır. Bu örnekte, bir sarkacın periyodu için formül şudur:

Periyot = 2 π √( (L / g) (1 + (1/4) sin^2(α/2)) )

Burada:
- g = 980 cm/sn^2
- π = 3.14159
- L = Sarkacın uzunluğu (cm)
- α = Yer değiştirme açısı (derece)![sarkaç şekli](/assets/pendulum.jpg)

g (yerçekimi) ve π sabit olarak tanımlanmalıdır. Formül, daha genel bir durumun
basitleştirilmiş bir versiyonudur. Bu nedenle, çok büyük, çok küçük veya sıfır açı değerleri için formül doğru sonuçlar
vermez. Bu örnek için bu kabul edilebilir.
Görüldüğü gibi, sarkaç sabit bir noktaya bağlıdır ve α açısı kadar yer değiştirilerek harekete
geçirilir. Program, g ve π için sabitleri tanımlamalı, değişkenleri bildirmeli, uygun istemleri
göstermeli, L ve α değerlerini okumalı, ardından verilen uzunluk ve yer değiştirme açısı ile sarkacın
periyodunu hesaplamalı ve görüntülemelidir.

## 7.2 Algoritma Oluşturma

Algoritma, bir problemin çözümü için izlenecek adımların mantıksal bir sıralamasıdır. Algoritma, programlama dilinden bağımsızdır ve kişiden kişiye değişebilir. Algoritmalar genellikle akış diyagramları veya yalın metin kullanılarak ifade edilir. Bu örnek için algoritma şu akış diyagramı ile görselleştirilebilir:  

```mermaid
graph TD
	Start([Başla]) --> DefineConstants["g ve π sabitlerini tanımla"]
	DefineConstants --> DeclareVars["L ve α değişkenlerini bildir"]
	DeclareVars --> PromptUser["Kullanıcıdan L ve α değerlerini iste"]
	PromptUser --> ReadValues["L ve α değerlerini oku"]
	ReadValues --> Compute["Periyot'u hesapla"]
	Compute --> Display["Periyot'u görüntüle"]
	Display --> End([Bitir])
```

Bu algoritma, programın mantığını ve akışını açıkça tanımlar. Her adım, programın belirli bir işlevini temsil eder.

## 7.3 Programı Uygulama
- Değişkenler ve sabitlerin belirlenmesi
    - radian = derece × (π / 180)
    - Sabitlerin tanımlanması
      ```fortran
      real(kind=8), parameter :: g = 980.0_8
      real(kind=8), parameter :: pi = 3.141592653589793_8
      ```
    - Değişkenlerin bildirilmesi
      ```fortran
      real(kind=8) :: L, alpha_deg, alpha_rad, period
      ```
- Girdi istemlerinin oluşturulması
    - Kullanıcıdan L ve α değerlerini isteme
      ```fortran
      print *, "Sarkacın uzunluğunu (cm) girin:"
      print *, "Yer değiştirme açısını (derece) girin:"
      ```
- Girdi alma
    - Kullanıcıdan L ve α değerlerini okuma
      ```fortran
      read *, L
      read *, alpha_deg
      ```
- Radian-derece dönüşümü için yardımcı ifade
    - Dereceyi radiana dönüştürme
      ```fortran
      alpha_rad = alpha_deg * (pi / 180.0_8)
      ```
- Periyot hesaplama
    - Formülü kullanarak periyodu hesaplama
      ```fortran
      period = 2.0_8 * pi * sqrt( (L / g) * (1.0_8 + 0.25_8 * sin(alpha_rad / 2.0_8)**2) )
      ```   
- Çıktı görüntüleme
    - Hesaplanan periyodu görüntüleme
      ```fortran
      print *, "Sarkacın periyodu (sn): ", period
      ```

***Programın tamamı aşağıdaki gibidir:***

```fortran
program pendulum
  ! Sarkacın periyodunu hesaplayan tam program (Modern Fortran)
  implicit none

  real(kind=8), parameter :: g = 980.0_8                ! yerçekimi (cm/s^2)
  real(kind=8), parameter :: pi = 3.141592653589793_8
  real(kind=8) :: L           ! sarkacın uzunluğu (cm)
  real(kind=8) :: alpha_deg   ! yer değiştirme açısı (derece)
  real(kind=8) :: alpha_rad   ! açı (radyan)
  real(kind=8) :: period

  ! Kullanıcı istemleri
  print *, 'Sarkacın uzunluğunu (cm) girin:'
  read  (*,*) L
  print *, 'Yer değiştirme açısını (derece) girin:'
  read  (*,*) alpha_deg

  ! Girdi doğrulama
  if (L <= 0.0_8) then
     print *, 'Hata: Uzunluk pozitif olmalıdır.'
     stop 1
  end if

  ! Derece -> Radyan dönüşümü
  alpha_rad = alpha_deg * (pi / 180.0_8)

  ! Periyot hesaplama (formül: 2π sqrt( (L/g) (1 + 1/4 sin^2(α/2)) ))
  period = 2.0_8 * pi * sqrt( (L / g) * (1.0_8 + 0.25_8 * sin(alpha_rad / 2.0_8)**2) )

  ! Sonucu göster
  write (*,'(A,F8.4,A)') 'Sarkacın periyodu (sn) = ', period, ' '

  ! Derleme ve çalıştırma örneği (komut satırında):
  ! gfortran -o pendulum pendulum.f90
  ! ./pendulum

end program pendulum
```

## 7.4 Programı Test/Debug Etme

Programı yazdıktan sonra, doğru çalıştığından emin olmak için test etmek önemlidir. Test süreci, programın beklenen çıktıları ürettiğini doğrulamak için çeşitli girdilerle çalıştırılmasını içerir. Bu örnekte, farklı uzunluk ve açı değerleri kullanılarak program test edilebilir.
Örneğin:
- L = 100 cm, α = 10 derece
- L = 50 cm, α = 30 derece
- L = 200 cm, α = 45 derece
Her test durumu için, programın ürettiği periyot değerinin beklenen değere yakın olup olmadığını kontrol edin. Eğer program beklenmeyen sonuçlar veriyorsa, kodu gözden geçirip hataları düzeltin. Debugging araçları veya basit `print` ifadeleri kullanarak değişken değerlerini izleyebilir ve hataların kaynağını belirleyebilirsiniz.
Bu metodolojiyi izleyerek, Fortran programları daha etkili bir şekilde geliştirilebilir ve hatalar minimize edilebilir. Her adım, programın kalitesini ve güvenilirliğini artırmaya yardımcı olur.

## 7.4.1 Compiler hata mesajları
Fortran derleyicileri, kodunuzda hatalar veya uyarılar bulduklarında genellikle anlamlı hata mesajları sağlar. Bu mesajlar, hatanın nerede olduğunu ve ne tür bir hata olduğunu belirtir. İşte bazı yaygın hata türleri ve bunların nasıl ele alınacağına dair ipuçları:
- Sözdizimi Hataları: Yanlış yazılmış anahtar kelimeler, eksik parantezler veya noktalama işaretleri gibi hatalar. Hata mesajları genellikle hatanın satır numarasını belirtir.
- Tür Uyuşmazlıkları: Değişken türlerinin uyumsuz olduğu durumlar. Örneğin, bir `real` değişkenine `integer` bir değer atamaya çalışmak.
- Bildirim Hataları: Değişkenlerin veya prosedürlerin bildirilmemesi. `implicit none` kullanıyorsanız, tüm değişkenlerin açıkça bildirilmesi gerekir.
- Mantıksal Hatalar: Programın derlenip çalıştırılmasına rağmen beklenmeyen sonuçları vermemesi. Bu tür hatalar genellikle kodun dikkatli bir şekilde gözden geçirilmesini ve test edilmesini gerektirir.
Hata mesajlarını dikkatlice okuyun ve, genellikle sorunun ne olduğunu ve nasıl düzeltileceğini anlamanıza yardımcı olacak ipuçlar arayın. Gerekirse, hata mesajını çevrimiçi kaynaklarda arayarak daha fazla bilgi edinebilirsiniz.

```bash
c:\mydir> gfortran -o period period.f95
period.f95:13.1:
 wrote (*,*)
1
Error: Unclassifiable statement at (1)
```
Bu hata mesajı, `wrote` ifadesinin Fortran sözdiziminde geçerli bir ifade olmadığını belirtir. Doğru ifade `write` olmalıdır. Hata mesajında belirtilen satır numarasına gidin ve ifadeyi düzeltin:

```fortran
write (*,*) "Sarkacın uzunluğunu (cm) girin:"
```
Bu düzeltmeden sonra, programı tekrar derleyin ve çalıştırın. Hata mesajları, kodunuzdaki sorunları tanımlamanıza ve düzeltmenize yardımcı olmak için önemli araçlardır.

## 7.4.2 Runtime Hataları
Derleme zamanında ortaya çıkmayan ancak program çalışırken meydana gelen hatalar da vardır.
Örneğin, kullanıcıdan alınan girdilerin beklenmedik değerler içermesi durumunda program hatalarla karşılaşabilir. Bu tür hataları önlemek için girdi doğrulama eklemek önemlidir. Örneğin, sarkacın uzunluğu negatif veya sıfır olamaz. Bu durumu kontrol etmek için aşağıdaki kod parçasını kullanabilirsiniz:

```fortran
if (L <= 0.0_8) then
   print *, 'Hata: Uzunluk pozitif olmalıdır.'
   stop 1
end if
```
Bu kontrol, kullanıcı yanlış bir değer girdiğinde programın düzgün bir şekilde hata mesajı vermesini ve sonlanmasını sağlar. Runtime hatalarını ele almak için benzer kontrolleri diğer girdiler için de ekleyebilirsiniz. Bu, programınızın daha sağlam ve kullanıcı dostu olmasını sağlar.
## 7.4.3 Mantıksal Hatalar

Mantıksal hatalar (logic errors), program derlenip çalışsa bile beklenen sonuçları üretmemesine neden olan hatalardır. Bu tür hatalar sıklıkla sayısal ifadelerdeki tür (integer/real) karışımlarından veya sabit literallerin yanlış yazılmasından kaynaklanır. Aşağıda sık karşılaşılan bir örnek ve doğru hali gösterilmiştir.

Yanlış örnek — tam sayı bölmesi sebebiyle 1/4 ifadesi 0 döner:
```fortran
! Yanlış: 1/4 tam sayı bölmesi -> sonuç 0 olur
pperiod = 2.0 * pi * sqrt(length/gravity) * &
         ( 1.0 + 1/4 * sin(alpha/2.0)**2 )
```

Doğru örnek — tüm sabitleri gerçek (real) literal olarak yazın ve proje standardı olan kind eklerini kullanın:
```fortran
! Doğru: gerçek literaller kullanılarak doğru hesaplama (kind=8)
pperiod = 2.0_8 * pi * sqrt( (length / gravity) ) * &
         ( 1.0_8 + 0.25_8 * sin(alpha/2.0_8)**2 )
```
Alternatif olarak açık bölüm kullanabilirsiniz:
```fortran
pperiod = 2.0_8 * pi * sqrt( (length / gravity) ) * &
         ( 1.0_8 + (1.0_8/4.0_8) * sin(alpha/2.0_8)**2 )
```

Kısa kurallar:
- Sabitlerde integer/real karışımından kaçının; bölme yaparken real literal kullanın (ör. 0.25_8 veya 1.0_8/4.0_8).
- Proje standardı olan real(kind=8) ve literal suffix (_8) kullanılmalıdır.
- Uzun ifadelerde satır devamı için & kullanın ve parantezlemeye dikkat edin.
- Mantıksal hataları tespit etmek için küçük, bilinen girdilerle test edin ve ara print/trace kullanın.

## 7.5 Alıştırmalar (Exercises)

### 7.5.1 Alıştırma Sınavı (quiz)

- Program geliştirme metodolojisinin ana adımları nelerdir?
- Bir algoritma nedir ve nasıl ifade edilebilir?
- Bir Fortran programında girdi doğrulama neden önemlidir?
- Hata tiplerinden üç tanesini açıklayın.

### 7.5.2 Önerilen Alıştırmalar (Suggested Exercises)

1. Sarkacın periyodunu hesaplayan programı yazın ve farklı uzunluk ve açı değerleriyle test edin.
2. Girdi doğrulama ekleyin: Uzunluk pozitif olmalı ve açı 0-180 derece arasında olmalıdır.
3. Programı genişleterek, kullanıcıdan kaç sarkaç periyodu hesaplamak istediğini sorun ve sonuçları listeleyin.
4. Kürenin yüzey alanını ve hacmini hesaplayan bir program yazın. Yarıçapı kullanıcıdan alın.

# 8. Seçim İfadeleri ve Mantıksal İfadeler (Selection Statements and Logical Operators)

Seçim ifadeleri, programın **hangi koşulda hangi yolu izleyeceğini** belirler. Fortran’da iki temel seçim yapısı vardır:

- `if` / `else if` / `else`: Koşula bağlı dallanma (genel amaçlı)
- `select case`: Tek bir ifade/değişkenin değerine göre dallanma (menüler ve sınıflandırma için daha okunaklı)

Mantıksal ifadeler ise koşulların kurulmasında kullanılan karşılaştırmalar ve mantıksal bağlaçlardır.

## 8.1 Karşılaştırma Operatörleri (Relational Operators)

Karşılaştırmaların sonucu **logical** türdür (`.true.` veya `.false.`).

| Anlam | Modern gösterim | Noktalı (eski) gösterim |
|------|------------------|--------------------------|
| eşittir | `==` | `.eq.` |
| eşit değildir | `/=` | `.ne.` |
| küçüktür | `<` | `.lt.` |
| küçük eşittir | `<=` | `.le.` |
| büyüktür | `>` | `.gt.` |
| büyük eşittir | `>=` | `.ge.` |

**Önemli notlar (özellikle hata kaynağı olan yerler):**
- `real` türlerinde `==` ile “tam eşitlik” çoğu zaman güvenilir değildir (yuvarlama/temsil hataları). Gerekirse tolerans kullanın.
- `integer` ile `real` karışımlarında otomatik tür dönüşümü olabilir; tür dönüşümü ve hassasiyet kaybı riskini azaltmak için sabitleri `..._8` gibi aynı kind ile yazın.

Örnek (tolerans ile real karşılaştırma):
```fortran
program real_compare_example
  implicit none
  real(kind=8) :: a, b, tol

  a = 0.1_8 + 0.2_8
  b = 0.3_8
  tol = 1.0e-12_8

  if (abs(a - b) < tol) then
     print *, 'a ve b tolerans icinde esit.'
  else
     print *, 'a ve b farkli.'
  end if
end program real_compare_example
```

## 8.2 Mantıksal Operatörler (Logical Operators)

Fortran’da mantıksal operatörler noktalı biçimdedir:

| Operatör | Anlam |
|---------|------|
| `.and.` | VE (AND) |
| `.or.`  | VEYA (OR) |
| `.not.` | DEĞİL (NOT) |
| `.eqv.` | Mantıksal eşdeğerlik (ikisi de aynıysa `.true.`) |
| `.neqv.`| Mantıksal eşdeğer değil (farklıysa `.true.`) |

> Not: Fortran’da `&&`, `||`, `!` gibi C-türevi mantıksal operatörler yoktur.

### 8.2.1 Mantıksal değerler ve değişkenler
Mantıksal tür: `logical :: is_valid`

```fortran
program logical_example
  implicit none
  logical :: is_valid
  integer :: n

  n = 5
  is_valid = (n > 0)

  if (is_valid) then
     print *, 'n pozitiftir.'
  end if
end program logical_example
```

### 8.2.2 Değerlendirme sırası (short-circuit) uyarısı
Fortran standardı `.and.` / `.or.` içinde **kısa devre değerlendirmeyi garanti etmez**. Güvenlik gerekiyorsa ifadeleri ayırın.

Riskli (her derleyicide güvenli olduğu varsayılmamalı):
```fortran
! x == 0 iken (y/x) ifadesi hesaplanabilir -> runtime hata riski
if (x /= 0.0_8 .and. (y/x) > 2.0_8) then
   ...
end if
```

Güvenli yaklaşım (iç içe if):
```fortran
if (x /= 0.0_8) then
   if ((y/x) > 2.0_8) then
      print *, 'Kosul saglandi.'
   end if
end if
```

## 8.3 IF Yapıları (if / then / else)

### 8.3.1 Tek satırlık IF (logical IF)
Basit tek eylem için:
```fortran
if (n < 0) print *, 'Negatif'
```

### 8.3.2 Blok IF (en okunaklı ve en yaygın)
```fortran
if (n > 0) then
   print *, 'Pozitif'
end if
```

### 8.3.3 if / else
```fortran
if (n >= 0) then
   print *, 'Sifir veya pozitif'
else
   print *, 'Negatif'
end if
```

### 8.3.4 if / else if / else zinciri (çoklu koşul)
```fortran
program if_chain_example
  implicit none
  real(kind=8) :: temperature_c

  print *, 'Sicakligi (C) girin:'
  read  (*,*) temperature_c

  if (temperature_c < 0.0_8) then
     print *, 'Donma noktasinin altinda.'
  else if (temperature_c <= 100.0_8) then
     print *, '0 ile 100 C araliginda.'
  else
     print *, '100 C ustunde.'
  end if
end program if_chain_example
```

### 8.3.5 Birleşik koşullar (parantez ve öncelik)
Koşul okunabilirliği için parantez kullanın:
```fortran
if ( (length_cm > 0.0_8) .and. (alpha_deg >= 0.0_8) .and. (alpha_deg <= 180.0_8) ) then
   print *, 'Girdiler gecerli.'
else
   print *, 'Girdiler gecersiz.'
end if
```

### 8.3.6 İç içe IF (girdi doğrulama için tipik desen)
```fortran
program input_validation_example
  implicit none
  real(kind=8) :: length_cm, alpha_deg

  print *, 'Uzunlugu (cm) girin:'
  read  (*,*) length_cm

  if (length_cm <= 0.0_8) then
     print *, 'Hata: Uzunluk pozitif olmalidir.'
     stop 1
  end if

  print *, 'Aciyi (derece) girin:'
  read  (*,*) alpha_deg

  if (alpha_deg < 0.0_8) then
     print *, 'Hata: Aci negatif olamaz.'
     stop 1
  else if (alpha_deg > 180.0_8) then
     print *, 'Hata: Aci 180 dereceden buyuk olmamalidir.'
     stop 1
  end if

  print *, 'Girdiler gecerli.'
end program input_validation_example
```

## 8.4 SELECT CASE Yapısı

`select case`, özellikle **menü** ve **kategori** seçimi gibi durumlarda `else if` zincirinden daha okunaklıdır.

Genel şablon:
```fortran
select case (ifade)
case (deger1)
   ...
case (deger2, deger3)
   ...
case (alt:ust)
   ...
case default
   ...
end select
```

### 8.4.1 Sayısal menü örneği
```fortran
program select_case_menu_example
  implicit none
  integer :: choice

  print *, '1- Topla  2- Cikar  3- Cikis'
  read  (*,*) choice

  select case (choice)
  case (1)
     print *, 'Toplama secildi.'
  case (2)
     print *, 'Cikarma secildi.'
  case (3)
     print *, 'Cikis.'
  case default
     print *, 'Gecersiz secim.'
  end select
end program select_case_menu_example
```

### 8.4.2 Aralık (range) ve birden çok değer örneği
```fortran
select case (choice)
case (1:5)
   print *, '1 ile 5 arasinda.'
case (10, 20, 30)
   print *, '10, 20 veya 30.'
case default
   print *, 'Diger.'
end select
```

### 8.4.3 Karakter (string) ile select case örneği
```fortran
program select_case_string_example
  implicit none
  character(len=10) :: mode

  print *, 'Mod girin (auto/manual):'
  read  (*,*) mode

  select case (trim(mode))
  case ('auto')
     print *, 'Otomatik mod.'
  case ('manual')
     print *, 'Manuel mod.'
  case default
     print *, 'Bilinmeyen mod.'
  end select
end program select_case_string_example
```

## 8.5 IF İçinde Atama (Fortran’da neden yapılmaz?)

Bazı dillerde “koşul içinde atama” görülebilir; Fortran’da **koşul parantezi içinde atama yapılamaz**. Doğru yaklaşım: önce oku/hesapla, sonra `if` ile kontrol et.

```fortran
program assignment_then_if_example
  implicit none
  integer :: n

  print *, 'Bir tamsayi girin:'
  read  (*,*) n

  if (n > 0) then
     print *, 'Pozitif.'
  else if (n < 0) then
     print *, 'Negatif.'
  else
     print *, 'Sifir.'
  end if
end program assignment_then_if_example
```
### 8.5.1 iostat ile Hata Yakalama ve Koşullu Dallanma (Güvenli Girdi Okuma)

Kullanıcı girdisi beklenmedik (harf, boş, hatalı format) olduğunda `read(*,*)` çalışırken hata oluşabilir. Bu tür durumları güvenli şekilde yakalamak için `iostat` ve isteğe bağlı `iomsg` kullanılabilir. Bu sayede program **çökmek yerine** kullanıcıyı uyarıp tekrar girdi isteyebilir.

Aşağıdaki örnekte kullanıcıdan pozitif bir sayı okunur. Hatalı girişte `iostat` sıfırdan farklı olur ve `iomsg` hata mesajını verir:

```fortran
program iostat_input_example
  implicit none

  integer :: io_stat
  character(len=200) :: io_msg
  real(kind=8) :: length_cm

  do
     print *, 'Uzunlugu (cm) girin (pozitif sayi):'
     read (*,*, iostat=io_stat, iomsg=io_msg) length_cm

     if (io_stat /= 0) then
        print *, 'Girdi okunamadi. Lutfen sayisal bir deger girin.'
        print *, 'Detay: ', trim(io_msg)
        cycle
     end if

     if (length_cm <= 0.0_8) then
        print *, 'Hata: Uzunluk pozitif olmalidir.'
        cycle
     end if

     exit
  end do

  print *, 'Gecerli uzunluk alindi: ', length_cm
end program iostat_input_example
```

Notlar:
- `iostat=0` ise okuma başarılıdır.
- `iomsg` ile derleyicinin ürettiği açıklayıcı hata metni alınabilir.
- Girdi doğrulama (ör. pozitif olma şartı) başarısızsa `cycle` ile döngü tekrar başlatılır.
## 8.6 Alıştırmalar (Exercises)

### 8.6.1 Alıştırma Sınavı (Quiz)
- `if` ve `select case` yapılarının temel farkı nedir? Hangi durumda hangisi daha okunaklı olur?
- Fortran’da mantıksal operatörler nelerdir? `&&` ve `||` neden kullanılamaz?
- Neden `real` sayılar için `==` karşılaştırması risklidir? Toleranslı karşılaştırma nasıl yapılır?
- Kısa devre (short-circuit) değerlendirme neden her zaman varsayılmamalıdır?

### 8.6.2 Önerilen Alıştırmalar (Suggested Exercises)
1. Kullanıcıdan bir tamsayı alıp:
   - negatifse “Negatif”, sıfırsa “Sıfır”, pozitifse “Pozitif” yazdıran bir program yazın (`if/else if/else`).
2. Kullanıcıdan 1–4 arasında bir seçim alan bir menü yazın ve `select case` ile işlem yaptırın.
3. Kullanıcıdan `real(kind=8)` iki sayı alıp tolerans ile “eşit / farklı” kararını veren bir program yazın.
4. Sıfıra bölme riskini içeren bir koşulu önce riskli şekilde yazın, sonra iç içe `if` ile güvenli hale getirin ve farkı açıklayın.

### 8.6.3 PDF Örnekleri (Çeviri) — 8.4 “Example One” ve 8.6 “Example Two”

Aşağıdaki iki örnek, seçim ifadelerinin (özellikle `if/else if/else` ve `select case`) gerçek bir problem üzerinde nasıl kullanıldığını gösterir.

#### 8.6.3.1 Örnek 1 — İkinci Dereceden Denklem Çözücü (Quadratic Solver)

**Problem:**
$a x^2 + b x + c = 0$ denkleminin köklerini hesaplayın.

**Kilit fikir (ayırt edici / discriminant):**
$$\Delta = b^2 - 4ac$$

- $\Delta > 0$ ise iki farklı **gerçek** kök
- $\Delta = 0$ ise bir **çift katlı** (tekrarlı) gerçek kök
- $\Delta < 0$ ise iki **karmaşık** kök

Bu örnek depoda hazırdır:
- Kaynak: [`quadratic.f90`](quadratic.f90)
- Dokümantasyon: [`quadratic.md`](quadratic.md)

**Geliştirme alıştırması (isteğe bağlı):**
- `iostat`/`iomsg` ile güvenli okuma ekleyin.
- $\Delta = 0$ durumunu gerçek sayılarda toleranslı biçimde ele alın (`abs(disc) <= tol`).

Repo’daki sürüm (özetle aynı kod):
```fortran
program quadratic
  ! Modern Fortran örneği: İkinci dereceden denklem çözümü
  !
  ! Denklem: a*x^2 + b*x + c = 0
  ! Ayırt edici (discriminant): Δ = b^2 - 4ac
  !
  ! Δ > 0  : iki farklı gerçek kök
  ! Δ = 0  : tek (tekrarlı) gerçek kök
  ! Δ < 0  : iki karmaşık kök
  !
  implicit none

  real(kind=8) :: a_coef, b_coef, c_coef
  real(kind=8) :: disc
  real(kind=8) :: root1_r, root2_r
  complex(kind=8) :: root1_c, root2_c
  real(kind=8) :: tol
  integer :: io_stat
  character(len=200) :: io_msg

  print *, 'İkinci Dereceden Denklem Çözücü'
  print *, 'a*x^2 + b*x + c = 0'
  print *, 'a, b, c değerlerini giriniz (ör: 1 5 6):'

  read (*,*, iostat=io_stat, iomsg=io_msg) a_coef, b_coef, c_coef
  if (io_stat /= 0) then
     print *, 'Hata: Girdi okunamadı. Lütfen sayısal değerler giriniz.'
     print *, 'Detay: ', trim(io_msg)
     stop 1
  end if

  if (a_coef == 0.0_8) then
     print *, 'Hata: a = 0 olamaz (denklem ikinci dereceden değildir).'
     stop 1
  end if

  disc = b_coef*b_coef - 4.0_8*a_coef*c_coef

  ! Gerçek sayılarda == 0 karşılaştırması hassasiyet nedeniyle riskli olabilir.
  ! Bu nedenle küçük bir tolerans ile “sıfıra yakın” kontrolü yapılır.
  tol = 1.0e-12_8 * max(1.0_8, abs(b_coef*b_coef), abs(4.0_8*a_coef*c_coef))

  if (disc > tol) then
     root1_r = (-b_coef + sqrt(disc)) / (2.0_8*a_coef)
     root2_r = (-b_coef - sqrt(disc)) / (2.0_8*a_coef)

     print *, 'Δ > 0: İki farklı gerçek kök:'
     write (*,'(A,F12.6)') 'Kök 1 = ', root1_r
     write (*,'(A,F12.6)') 'Kök 2 = ', root2_r

  else if (abs(disc) <= tol) then
     root1_r = (-b_coef) / (2.0_8*a_coef)

     print *, 'Δ ≈ 0: Tek (tekrarlı) gerçek kök:'
     write (*,'(A,F12.6)') 'Kök = ', root1_r

  else
     root1_c = (-b_coef + sqrt(cmplx(disc, 0.0_8, kind=8))) / (2.0_8*a_coef)
     root2_c = (-b_coef - sqrt(cmplx(disc, 0.0_8, kind=8))) / (2.0_8*a_coef)

     print *, 'Δ < 0: İki karmaşık kök (format: (gerçek, sanal)):'
     print *, 'Kök 1 = ', root1_c
     print *, 'Kök 2 = ', root2_c
  end if

end program quadratic
```

#### 8.6.3.2 Örnek 2 — Not Harfi Atama (Grade Assignment)

**Problem:** Üç sınav notu okuyun, ortalamayı hesaplayın ve aşağıdaki ölçeğe göre harf notu verin:

- A: $\ge 90$
- B: 80–89
- C: 70–79
- D: 60–69
- F: $\le 59$

Bu örnek depoda hazırdır:
- Kaynak: [`grades.f90`](grades.f90)
- Dokümantasyon: [`grades.md`](grades.md)

**Geliştirme alıştırması (isteğe bağlı):**
- 0–100 aralığı doğrulamasını ekleyin.
- `iostat`/`iomsg` ile güvenli okuma yapın.

Repo’daki sürüm (özetle aynı kod):
```fortran
program grades
  ! Modern Fortran örneği: Not harfi atama (select case)
  !
  ! Kullanıcıdan 3 sınav notu (0-100) alınır, ortalaması hesaplanır.
  ! Ortalama en yakın tamsayıya yuvarlanır (nint) ve harf notu belirlenir.
  !
  implicit none

  real(kind=8) :: test1, test2, test3
  real(kind=8) :: average_score
  integer :: test_ave
  integer :: io_stat
  character(len=200) :: io_msg

  write (*,*) 'Not Atama Programı'
  write (*,*)
  write (*,*) 'Test 1, Test 2 ve Test 3 notlarını giriniz (0-100):'

  read (*,*, iostat=io_stat, iomsg=io_msg) test1, test2, test3
  if (io_stat /= 0) then
     print *, 'Hata: Girdi okunamadı. Lütfen sayısal değerler giriniz.'
     print *, 'Detay: ', trim(io_msg)
     stop 1
  end if

  if (test1 < 0.0_8 .or. test1 > 100.0_8) then
     print *, 'Hata: Test 1 notu 0 ile 100 arasında olmalıdır.'
     stop 1
  end if

  if (test2 < 0.0_8 .or. test2 > 100.0_8) then
     print *, 'Hata: Test 2 notu 0 ile 100 arasında olmalıdır.'
     stop 1
  end if

  if (test3 < 0.0_8 .or. test3 > 100.0_8) then
     print *, 'Hata: Test 3 notu 0 ile 100 arasında olmalıdır.'
     stop 1
  end if

  average_score = (test1 + test2 + test3) / 3.0_8
  test_ave = nint(average_score)

  write (*,'(A,F6.2)') 'Ortalama (real) = ', average_score
  write (*,'(A,I0)')   'Ortalama (nint) = ', test_ave

  select case (test_ave)
  case (90:)
     write (*,*) 'Harf Notu: A'
  case (80:89)
     write (*,*) 'Harf Notu: B'
  case (70:79)
     write (*,*) 'Harf Notu: C'
  case (60:69)
     write (*,*) 'Harf Notu: D'
  case (:59)
     write (*,*) 'Harf Notu: F'
  end select

end program grades
```


# 9. Döngüler (Looping)

Bu bölüm, Fortran’da bir veya daha fazla ifadeyi **tekrarlı** çalıştırmak için kullanılan döngü yapılarını açıklar. Döngüler iki ana grupta ele alınır:

- **Sayaç kontrollü döngüler**: Belirli sayıda tekrar (counter controlled)
- **Koşul kontrollü döngüler**: Bir mantıksal koşula bağlı tekrar (conditionally controlled)

Fortran’da temel döngü anahtar kelimesi `do`’dur ve döngü `end do` ile biter.

## 9.1 Sayaç Kontrollü Döngüler (Counter Controlled Looping)

Sayaç kontrollü döngü, bir `integer` sayaç değişkeninin belirli bir aralıkta ilerlemesiyle çalışır.

Genel biçim:

```fortran
do count = start, stop, step
   ! döngü gövdesi
end do
```

- `count` **integer** olmalıdır.
- `step` isteğe bağlıdır; yazılmazsa varsayılan değer `1`’dir.
- `step` değeri **0 olamaz**.
- `start`, `stop`, `step` değerleri döngü başında hesaplanır; döngü boyunca her tur yeniden hesaplanmaz.

### 9.1.1 Örnekler

**1) 1’den 10’a kadar toplam:**

```fortran
integer :: counter, sum

sum = 0
do counter = 1, 10
   sum = sum + counter
end do
write (*,*) 'Toplam = ', sum
```

**2) Adım kullanımı (tek sayılar):**

```fortran
integer :: counter

do counter = 1, 10, 2
   write (*,*) counter
end do
```

**3) N adet sayı okuyup ortalama alma:**

> Not: `sum/count` ifadesi iki `integer` ise sonuç da `integer` olur. Ortalama için tür dönüşümü gerekir.

```fortran
program calc_average
   implicit none
   integer :: count, i, sum, input
   real(kind=8) :: average

   write (*,*) 'Kac sayi okunacak?'
   read  (*,*) count

   sum = 0
   do i = 1, count
      read (*,*) input
      sum = sum + input
   end do

   average = real(sum, kind=8) / real(count, kind=8)
   write (*,*) 'Ortalama = ', average
end program calc_average
```

**4) Faktöriyel:**

```fortran
integer :: i, n
integer :: factorial

factorial = 1
do i = 1, n
   factorial = factorial * i
end do
```

## 9.2 `exit` ve `cycle` İfadeleri

`exit` ve `cycle`, bir döngünün yürütülmesini kontrol etmek için kullanılır:

- `exit`: Döngüden **tamamen çıkar** (döngü biter, `end do` sonrası devam eder).
- `cycle`: Döngünün kalan kısmını **atlar**, bir sonraki tura geçer.

### 9.2.1 `exit` örneği

```fortran
integer :: i

do i = 1, 10
   if (i == 5) exit
   write (*,*) i
end do
```

Bu örnekte 1–4 yazdırılır; `i==5` olduğunda döngü sonlandırılır.

### 9.2.2 `cycle` örneği

```fortran
integer :: i

do i = 1, 10
   if (i == 5) cycle
   write (*,*) i
end do
```

Bu örnekte 5 yazdırılmaz; diğer değerler yazdırılır.

## 9.3 Örnek (Sayaç Kontrollü) — “Karelerin Toplamı” ve “Toplamın Karesi”

Bu örnekte amaç; ilk $N$ doğal sayının:

- karelerinin toplamı: $1^2 + 2^2 + \dots + N^2$
- toplamının karesi: $(1 + 2 + \dots + N)^2$

değerleri arasındaki farkı hesaplamaktır.

### 9.3.1 Problemi Anlama
Önce iki ara değer hesaplanır (karelerin toplamı ve toplam), sonra toplamın karesi alınır ve fark bulunur.

### 9.3.2 Algoritma
- `n` oku
- `sum_of_squares = 0`, `sum = 0`
- `i = 1..n` döngüsü:
   - `sum_of_squares += i**2`
   - `sum += i`
- `square_of_sum = sum**2`
- `difference = square_of_sum - sum_of_squares`
- sonucu yazdır

### 9.3.3 Program (stil uyarlaması: `snake_case`)

Bu örnek depoda hazırdır:
- Kaynak: [`sos_difference.f90`](sos_difference.f90)
- Dokümantasyon: [`sos_difference.md`](sos_difference.md)

```fortran
program sos_difference
  ! Modern Fortran örneği: Döngüler (counter controlled)
  !
  ! Amaç:
  !   İlk N doğal sayının karelerinin toplamı ile
  !   bu sayıların toplamının karesi arasındaki farkı hesaplamak.
  !
  !   sum_of_squares = 1^2 + 2^2 + ... + N^2
  !   square_of_sum  = (1 + 2 + ... + N)^2
  !   difference     = square_of_sum - sum_of_squares
  !
  implicit none

  integer :: i, n
  integer :: sum_of_squares, sum, square_of_sum, difference
  integer :: io_stat
  character(len=200) :: io_msg

  write (*,*) 'Ornek Program'
  write (*,*) 'Karelerin toplami ile toplamın karesi arasindaki fark'
  write (*,*)
  write (*,*) 'N degerini girin (N >= 1):'

  read (*,*, iostat=io_stat, iomsg=io_msg) n
  if (io_stat /= 0) then
     print *, 'Hata: Girdi okunamadi. Lutfen bir tamsayi girin.'
     print *, 'Detay: ', trim(io_msg)
     stop 1
  end if

  if (n < 1) then
     print *, 'Hata: N en az 1 olmalidir.'
     stop 1
  end if

  sum_of_squares = 0
  sum = 0

  do i = 1, n
     sum_of_squares = sum_of_squares + i**2
     sum = sum + i
  end do

  square_of_sum = sum**2
  difference = square_of_sum - sum_of_squares

  write (*,'(A,I0)') 'N = ', n
  write (*,'(A,I0)') 'Karelerin toplami = ', sum_of_squares
  write (*,'(A,I0)') 'Toplamin karesi  = ', square_of_sum
  write (*,'(A,I0)') 'Fark             = ', difference

end program sos_difference
```

### 9.3.4 Test / Debug
- Küçük bir `n` seçip (örn. 10) sonucu el hesaplaması/hesap makinesi ile doğrulayın.
- Sonuç yanlışsa `sum_of_squares` ve `sum` değerlerini geçici `write` satırlarıyla kontrol edin.
- Gerekirse döngü içinde her adımda ara değerleri yazdırarak hatanın nerede oluştuğunu bulun.

## 9.4 Koşul Kontrollü Döngüler (Conditionally Controlled Looping)

Koşul kontrollü döngüler, bir koşul sağlandığı sürece (veya sağlanana kadar) çalışır; tekrar sayısı önceden belli olmayabilir.

### 9.4.1 `do while` biçimi

```fortran
do while (koşul)
   ! döngü gövdesi
end do
```

Koşul her tur başında kontrol edilir.

### 9.4.2 “Sonsuz döngü + çıkış koşulu” biçimi

```fortran
do
   ! ...
   if (koşul) exit
end do
```

Bu kalıp, kullanıcıdan doğru girdi gelene kadar tekrar sorma gibi senaryolarda çok kullanışlıdır.

### 9.4.3 Örnek: Ay numarası doğrulama

```fortran
integer :: month

do
   write (*,*) 'Ay girin (1-12):'
   read  (*,*) month
   if (month >= 1 .and. month <= 12) exit
   write (*,*) 'Hata: ay 1 ile 12 arasinda olmalidir. Tekrar deneyin.'
end do
```

### 9.4.4 Örnek: “gerçek sayaç” simülasyonu

Sayaç kontrollü `do i = ...` yapısı sayaç olarak `integer` ister. `real` adımlarla ilerlemek için `do while` kullanabilirsiniz:

```fortran
real(kind=8) :: curr_value

curr_value = 1.5_8
do while (curr_value <= 4.5_8)
   write (*,*) 'Deger = ', curr_value
   curr_value = curr_value + 0.25_8
end do
```

## 9.5 Örnek (Koşul Kontrollü) — Geçerli Tarih Okuma

Bu örnekte kullanıcıdan (ay, gün, yıl) okunur ve girilen tarihin geçerli olup olmadığı kontrol edilir. Kontroller başarısız olursa kullanıcıdan tekrar istenir.

### 9.5.1 Problemi Anlama
- Yıl: belirli bir aralıkta olmalı (örneğin 1970–2020)
- Ay: 1–12
- Gün: aya göre değişir (30/31/Şubat)
- Basit artık yıl (leap year) kontrolü: bu sınırlı aralık için `mod(year, 4) == 0` yaklaşımı kullanılabilir.

### 9.5.2 Algoritma
- (month, day, year) oku
- ay/yıl aralığını doğrula; hatalıysa `cycle`
- aya göre maksimum günü (`day_max`) belirle (`select case` + Şubat için artık yıl kontrolü)
- gün aralığını doğrula; hatalıysa `cycle`
- tüm kontroller geçtiyse `exit`
- geçerli tarihi yazdır

### 9.5.3 Program (stil uyarlaması: `snake_case`)

Bu örnek depoda hazırdır:
- Kaynak: [`date_check.f90`](date_check.f90)
- Dokümantasyon: [`date_check.md`](date_check.md)

```fortran
program date_check
  ! Modern Fortran örneği: Döngüler (conditionally controlled) + select case
  !
  ! Amaç:
  !   Kullanıcıdan (ay, gün, yıl) alıp tarihin geçerli olup olmadığını kontrol etmek.
  !   Hatalı girişlerde tekrar istemek.
  !
  ! Sınırlar (bu örnek için):
  !   yıl: 1970-2020
  !   ay : 1-12
  !   gün: aya ve (Şubat için) artık yıla göre
  !
  implicit none

  integer :: month, day, year, day_max
  integer :: io_stat
  character(len=200) :: io_msg

  write (*,*) 'Tarih Dogrulama Ornegi'
  write (*,*) 'Giris formati: ay gun yil  (orn: 12 31 2019)'

  do
     write (*,*)
     write (*,*) 'Ay, gun, yil girin:'
     read (*,*, iostat=io_stat, iomsg=io_msg) month, day, year

     if (io_stat /= 0) then
        write (*,*) 'Hata: Girdi okunamadi. Lutfen 3 adet tamsayi girin.'
        write (*,*) 'Detay: ', trim(io_msg)
        cycle
     end if

     if (month < 1 .or. month > 12) then
        write (*,*) 'Hata: Gecersiz ay (1-12).'
        cycle
     end if

     if (year < 1970 .or. year > 2020) then
        write (*,*) 'Hata: Gecersiz yil (1970-2020).'
        cycle
     end if

     select case (month)
     case (1, 3, 5, 7, 8, 10, 12)
        day_max = 31
     case (4, 6, 9, 11)
        day_max = 30
     case (2)
        if (mod(year, 4) == 0) then
           day_max = 29
        else
           day_max = 28
        end if
     end select

     if (day < 1 .or. day > day_max) then
        write (*,*) 'Hata: Gecersiz gun (1-', day_max, ').'
        cycle
     end if

     exit
  end do

  write (*,*)
  write (*,*) 'Gecerli tarih:', month, day, year

end program date_check
```

### 9.5.4 Test / Debug
- Sınır değerlerle deneyin: 2/28, 2/29 (artık yıl), 4/30, 4/31 (hata beklenir), 13/1 (hata), yıl aralığı dışı (hata).
- Hatalı girişte programın gerçekten döngünün başına dönüp dönmediğini kontrol edin.

## 9.6 Alıştırmalar

### 9.6.1 Kısa Sorular (Quiz)
1) `exit` çalışınca ne olur?
2) Bir döngü içinde kaç adet `exit` kullanılabilir?
3) `cycle` çalışınca ne olur?
4) Bir döngü içinde kaç adet `cycle` kullanılabilir?
5) Döngü içinde birden çok `cycle` varsa hangisi çalışır?
6) Aşağıdaki kodun çıktısı nedir?

```fortran
sum = 0
do i = 1, 5
   sum = sum + i
end do
write (*,*) 'The SUM is:', sum
```

7) Aşağıdaki iç içe döngünün çıktısı nasıl görünür?

```fortran
write (*,*) 'start'
do i = 1, 3
   do j = 1, 2
      write (*,*) i, ' * ', j, ' = ', (i*j)
   end do
end do
write (*,*) 'end'
```

8) `do i = 3, 2` yazarsanız döngü çalışır mı? Neden?
9) Döngü içinde açtığınız `if ... then` bloklarının doğru kapanması için nelere dikkat etmelisiniz?

### 9.6.2 Önerilen Projeler
1) 9.3’teki “fark” programını yazın, derleyin ve farklı `n` değerleriyle test edin.
2) 9.5’teki tarih doğrulama programını yazın, derleyin ve farklı tarihlerle test edin.
3) Bir topun menzilini (range) hesaplayan bir program yazın:
    - Kullanıcıdan ilk hız $v_0$ alın.
    - 5° ile 85° arasında her 5 derecede bir menzili hesaplayın.
    - Trigonometrik fonksiyonların radyan beklediğini unutmayın; dereceyi radyana çevirin.
    - Yerçekimini sabit olarak tanımlayın (örn. $g = -9.81\,m/s^2$).






