# Bölüm 13 ► Tek Boyutlu Diziler (Single Dimension Arrays)

Bu bölüm, tek boyutlu dizilerin tanımı, bildirimleri, okuma/yazma işlemleri ve örnek uygulamaları üzerine odaklanır. Örnek program, bir dosyadan sayıları okuyup temel istatistikleri (min, max, toplam, ortalama, standart sapma) hesaplar.

## 13.0 Tek Boyutlu Dizilere Giriş
Tek boyutlu diziler, aynı türden verilerin bellekte ardışık tutulduğu koleksiyonlardır. Doğrudan erişimlidirler: her elemana indisi ile O(1) sürede erişilir.

## 13.1 Bildirim ve Boyut
- Statik boyut: `real, dimension(10) :: arr`
- Parametre ile: `integer, parameter :: n=100` ardından `real, dimension(n) :: arr`
- Çalışma zamanında ayrılabilir: `real, allocatable :: arr(:); allocate(arr(n))`

## 13.2 İndeksleme ve Erişim
Diziler 1 tabanlıdır: `arr(1)` ilk elemandır. Alt aralık yazımı: `arr(2:5)`.

## 13.3 Başlatma ve Atama
Dizilere toplu atama yapılabilir: `arr = 0.0` tüm elemanları sıfırlar. Bireysel atama: `arr(3) = 5.5`.

## 13.4 Girdi/Çıktı
Dizi elemanları `read`/`write` ile sırayla okunup yazılabilir. Formatlı yazımda alt aralıklar da kullanılabilir.

## 13.5 Temel İşlemler
Toplam, minimum, maksimum ve ortalama için tipik kalıp:
```fortran
min_val = arr(1); max_val = arr(1); sum_val = 0.0
do i = 1, n
  if (arr(i) < min_val) min_val = arr(i)
  if (arr(i) > max_val) max_val = arr(i)
  sum_val = sum_val + arr(i)
end do
average = sum_val / real(n, kind=8)
```

## 13.6 Örnek: Standart Sapma Hesabı
### 13.6.1 Problemi Anlama (Understand the Problem)
Bir dosyadan sayılar okunacak; sayılar bir diziye alınacak; min, max, toplam, ortalama ve standart sapma hesaplanacak; sayılar ekranda 10'ar sütun halinde gösterilecek.

### 13.6.2 Algoritmayı Oluşturma (Create the Algorithm)
- Değişkenleri bildir: `i, ncount, errs, opstat, rdstat` (integer); `min, max, sum, stdsum` ve sayı dizisi (real); `filename` (character).
- Başlık göster.
- Döngü: dosya adını iste/oku, açmayı dene; başarısızsa hata say, mesaj bas; 4. hatada sonlandır; açılırsa çık.
- Döngü: dosyadan oku; okuma hatası varsa dur; EOF ise çık; sayacı artır; diziye ekle.
- Min/max/sum için başlangıç değerlerini ayarla (ilk eleman). Döngüyle min, max, toplam hesapla.
- Ortalama hesapla.
- Standart sapma için `stdsum` topla: `(ortalama - eleman)**2`. `std = sqrt(stdsum / (n-1))`.
- Sayıları 10'lu sütunlarla yazdır (`advance="no"`, her 10 elemanda satır sonu).
- Sonuçları yaz ve programı bitir.

### 13.6.3 Programı Uygulama (Implement the Program)
Ayrıntılı uygulama için [`standard_deviation.f90`](./standard_deviation.f90) ve açıklaması için [`standard_deviation.md`](./standard_deviation.md) dosyalarına bakın.

### 13.6.4 Test/Hata Ayıklama (Test/Debug the Program)
- Doğru sonuçları bilinen küçük veri setleriyle çalıştırın.
- Boş veya eksik dosya durumunda uyarıları ve sonlandırmayı doğrulayın.
- 10 eleman/satır yazımının hizalamasını kontrol edin.

## 13.7 String Dizileri (Arrays of Strings)
- Bildirimde uzunluk sabit olmalıdır: `character(40), dimension(100) :: titles`
- Atama örneği: `titles(1) = "Programming is fun!"` (40 karakteri aşmamalı).
- Statik veya dinamik (allocatable) olarak tanımlanabilir.

## 13.8 Alıştırmalar (Exercises)

### 13.8.1 Sınav Soruları (Quiz Questions)
1) Bir dizi neden doğrudan erişimli bir yapı olarak kabul edilir?
2) Diziler tamsayı tutabilir mi (evet/hayır)?
3) Diziler gerçek sayı tutabilir mi (evet/hayır)?
4) Aşağıdakileri bildirin:
   - 100'e eşit `SIZE1` tamsayı sabiti.
   - 10 elemanlı gerçek dizi `rvalues`.
   - `SIZE1` uzunluğunda tamsayı dizi `inums`.
   - İndis aralığı 0..9 olan 10 elemanlı gerçek dizi `counts`.
5) Aşağıdaki kod için:
```fortran
integer, dimension(4) :: arr
integer :: k
arr(1) = 10
arr(2) = 15
arr(3) = 20
arr(4) = 25
k = 3
```
   a) `arr(1)` nedir?
   b) `arr(1) + arr(2)` nedir?
   c) `arr(1+2)` nedir?
   d) `arr(k)` nedir?
6) Bir dizi ne zaman allocate edilebilir (iki seçenek)?
7) Aşağıdaki kod için:
```fortran
integer, dimension(5) :: nums
integer :: i=1
nums = 0
do
  if ( i == 5 ) exit
  if ( mod(i,2) == 0) then
    nums(i) = 99
  else
    nums(i) = i
  end if
  i = i + 1
end do
```
   a) Çalışma sonrası dizi değerleri nedir?
   b) `(nums(i), i=1,5)` ifadesi ne olarak adlandırılır?
   c) `write (*,'(1x,i2)') (nums(i), i=1,5)` ne yazar (boşlukları `_` ile gösterin)?

### 13.8.2 Önerilen Projeler (Suggested Projects)
1) Standart sapma programını derleyip farklı girdilerle test edin.
2) Bir dosyadaki tamsayıları küpleyen, orijinal ve küp değerlerin ortalamasını hesaplayan program yazın.
3) 1.0–100.0 arası rastgele gerçek değerler üretip diziye koyan ve vektör normu hesaplayan program yazın.
4) Dosyadan okunan sayıları seçim sıralaması (selection sort) ile sıralayan program yazın; verilen sözde kodu Fortran'a çevirin ve test edin.
