
# 12. Dosya İşlemleri (File Operations)
Fortran'da dosya işlemleri, veri okuma ve yazma için kullanılır. Aşağıda temel dosya işlemleri ve ilgili kavramlar açıklanmıştır.

## 12.1 Dosya Açma (File Open)
Bir dosyada yazma veya okuma işlemi yapmadan önce dosyayı açmanız gerekir. `open` ifadesi ile dosya açılır.

```fortran
open (unit=<unit_number>, file=<filename.txt>, status=<file_status>, action=<read_or_write>, iostat=<iostat_var>)
```

Aşağıdaki tabloda `open` ifadesindeki bazı önemli parametreleri göstermektedir:

| Parametre  | Açıklama                                                    |
|------------|-------------------------------------------------------------|
| `unit`     | Dosya birim numarası (benzersiz olmalı)                     |
| `file`     | Dosya adı (string)                                          |
| `status`   | Dosyanın durumu (`'old'`, `'new'`, `'replace'`, `'scratch'`) |
| `action`   | İşlem türü (`'read'`, `'write'`, `'readwrite'`)             |
| `iostat`   | Hata kodu için değişken (isteğe bağlı)                      |
| `position` | Dosya içindeki konumu ayarlamak için (isteğe bağlı)         |

## 12.2 Dosya Yazma (File Write)
Dosyaya veri yazmadan önce dosyanın "write" veya "readwrite" erişimiyle açılmış olması gerekir. `write` ifadesinin genel biçimi şöyledir:

```
write (unit=<unit number>, fmt=<format statement>, &
       advance="no", iostat=<variable>) &
       <variables/expressions>
```

`write` ifadesi, basit `write` ile aynıdır; ancak `unit` numarası, dosya açılırken atanan numara olmalıdır. Varsayılan olarak sonraki `write` bir sonraki satıra yazar. `advance="no"` isteğe bağlıdır; eklenirse sonraki yazma önceki satırın bittiği yerden devam eder.

Örneğin `temp.txt` adlı bir dosyayı açıp içine "Fortran Example" dizgesini ve 42 ile 3.14159 sayılarını ayrı satırlara yazmak için aşağıdaki bildirimler yapılır:

```fortran
integer :: myanswer=42, myopenstatus, mywritestatus
real, parameter :: pi=3.14159
character(15) :: mymessage="Fortran Example"
character(8) :: myfilename="temp.txt"
```

Ardından şu Fortran ifadeleri kullanılır:

```fortran
open (unit=10, file=myfilename, status="replace", &
      action="write", position="rewind", &
      iostat=myopenstatus)
if (myopenstatus > 0) stop "Cannot open file."

write (10, '(a/, i5/, f7.5)', iostat=mywritestatus) &
     mymessage, myanswer, pi
```

Bu kod satırları bilgiyi dosyaya yazar.

## 12.3 Stop Uyarısı (Stop Statement)
Dosya açma veya yazma işlemi başarısız olursa, `iostat` değişkeni sıfırdan büyük bir değere ayarlanır. Bu durumda programı durdurmak için `stop` ifadesi kullanılabilir. Yukarıdaki örnekte, dosya açılamazsa program "Cannot open file." mesajıyla durdurulur.

## 12.4 Dosya Okuma (File Read)
Dosyadan veri okunmadan önce dosyanın "read" veya "readwrite" erişimiyle açılmış olması gerekir. `read` ifadesinin genel biçimi şöyledir:

```fortran
read (unit=<unit number>, fmt=<format statement>, &
     iostat=<variable>) <variables>
```

`read` basit `read` ile aynıdır; ancak `unit` numarası, dosya açılırken atanan numara olmalıdır. `iostat` değişkeni 0'dan küçük olursa dosya sonuna gelindiği anlamına gelir.

Örneğin, `numbers.txt` dosyası varsa ve iki sayı (ayrı satırlarda) içeriyorsa şu bildirimler yapılabilir:

```fortran
integer :: num1, num2, myopenstatus, myreadstatus
character(11) :: myfilename = "numbers.txt"
```

Ardından:

```fortran
open (unit=12, file=myfilename, status="old", &
      action="read", position="rewind", &
      iostat=myopenstatus)
if (myopenstatus > 0) stop "Cannot open file."

read (12, '(i5)', iostat=myreadstatus) num1
read (12, '(i5)', iostat=myreadstatus) num2
```

Bu ifadeler dosyadan iki tamsayıyı okur.

## 12.5 Dosyayı Başa Alma (Rewind)
Açık bir dosya başa sarılabilir; böylece dosya yeniden okunabilir. Genel biçim:

```fortran
rewind(<unit number>)
```

`unit` numarası dosya açılırken verilen numaradır. Dosya açıkken çağrılmalıdır.

## 12.6 Geri Al (Backspace)
Bir dosya okurken her `read` sonraki satırı getirir. Aynı satırı yeniden okumak için `backspace` kullanılabilir:

```fortran
backspace(<unit number>)
```

`unit` numarası açılışta verilen numaradır; dosya açık olmalıdır. Bu işlem pratikte nadir kullanılır.

## 12.7 Dosya Kapatma (Close File)
Artık gerekmediğinde dosya kapatılmalıdır:

```fortran
close(<unit number>)
```

Önceki örneklerde açılan dosyalar için:

```fortran
close(10)
close(12)
```

## 12.8 Örnek (Example)
Bu örnekte, bir giriş dosyasını okuyup satır numarasını ve satırı çıktı dosyasına yazan bir program yazacağız.

### 12.8.1 Problemi Anlama (Understand the Problem)
Girdi ve çıktı dosya adları kullanıcıdan alınacak, dosyalar açılacak, her satır okunup satır numarasıyla birlikte çıktı dosyasına yazılacak, sonra dosyalar kapatılacak.

### 12.8.2 Algoritmayı Oluşturma (Create the Algorithm)

```fortran
! değişkenleri bildir
! integer -> i, rdopst, wropst
! character -> line
! başlık göster
! döngü: girdi dosya adını iste, oku, aç; başarısızsa uyar, tekrar dene
! döngü: çıktı dosya adını iste, oku, aç; başarısızsa uyar, tekrar dene
! i = 1
! döngü: satır oku; eof ise çık; hata ise stop
!        satır numarası ve satırı yaz
!        i = i + 1
! dosyaları kapat
```

### 12.8.3 Programı Uygulama (Implement the Program)

```fortran
program linenumbers
  implicit none
  integer :: i, rdopst, wropst, rdst
  character(30) :: rdfile, wrfile
  character(132) :: line
  ! başlık
  write (*,*) "Line Number Example"
  ! ---------
  ! giriş dosyası
  do
    write (*,'(a)', advance="no") "Input File Name: "
    read (*,*) rdfile
    open(12, file=rdfile, status="old", action="read", position="rewind", iostat=rdopst)
    if (rdopst == 0) exit
    write (*,'(a/,a)') "Unable to open input file.", "Please re-enter"
  end do
  ! ---------
  ! çıkış dosyası
  do
    write (*,'(a)', advance="no") "Output File Name: "
    read (*,*) wrfile
    open(14, file=wrfile, status="replace", action="write", position="rewind", iostat=wropst)
    if (wropst == 0) exit
    write (*,'(a, a/,a)') "Unable to open ", "output file.", "Please re-enter"
  end do
  ! ---------
  i = 1
  do
    read (12, '(a)', iostat=rdst) line
    if (rdst > 0) stop "read error"
    if (rdst < 0) exit
    write (14, '(i10,2x,a)') i, line
    i = i + 1
  end do
  close(12)
  close(14)
end program linenumbers
```

Boşluk ve girintiler isteğe bağlıdır fakat okunabilirliği artırır.

### 12.8.4 Programı Test Etme/Hata Ayıklama (Test/Debug the Program)
Farklı giriş dosyalarıyla çalıştırıp satır numaralarının doğru eklendiğini doğrulayın.

## 12.9 Alıştırmalar (Exercises)

### 12.9.1 Sınav Soruları (Quiz Questions)
1) Bir dosya okunmadan veya yazılmadan önce ne yapılmalıdır?
2) Geçerli birim numarası aralığı nedir?
3) Aşağıdaki ifadeler için:

```fortran
integer :: opnstat
character(20) :: filename="file.txt"
open (14, file=filename, status="old", action="read", &
      position="rewind", iostat=opnstat)
if ( opnstat > 0 ) then
  write (*, *) "Error, can not open file."
  stop
end if
```
   a) Açılan dosyanın adı nedir?
   b) Yazma işlemleri için hangi birim numarası kullanılacaktır?
   c) Dosya yoksa hata mesajı basılır mı (evet/hayır)?
   d) `status` değişkeni > 0 olursa ne anlama gelir?
4) `answers.txt` dosyası varsa, ünite 20 ile açıldıysa ve satır olarak `"line 1 data1=23 data2 =034 data3 =05123"` içeriyorsa, `data1`, `data2`, `data3` değerlerini `integer` değişkenlere okumak için gereken `read` ifadesi nedir?

### 12.9.2 Önerilen Projeler (Suggested Projects)
1) Satır numarası örneğini yazın, derleyin ve farklı girdilerle test edin.
2) Bir episiklik eğri (Spirograph) noktalarını üreten program yazın: çıktı dosyasını kullanıcıdan alın; yarıçap1, yarıçap2, ofset değerleri için -100..100 aralığını doğrulayın; üç hata sonrası sonlandırın; adım 0.0'dan 360.0'a 0.1 artımla ilerlesin; biçimlendirilmiş çıktı kullanın; bitince dosyayı kapatıp kullanıcıyı bilgilendirin.
3) Chaos Game oynayan bir program yazın: A, B, C noktalarını ve başlangıç noktası X1'i belirleyin; her adımda 1-3 arası rastgele seçimle orta noktayı bulun ve yeni nokta olarak atayın; N kez yineleyin. Rastgele sayı üretimi için Ek C'ye bakın; çıktı Sierpinski Üçgeni oluşturmalıdır.# 12. Dosya İşlemleri (File Operations )
Fortran'da dosya işlemleri, veri okuma ve yazma için kullanılır. Aşağıda temel dosya işlemleri ve ilgili kavramlar açıklanmıştır.

