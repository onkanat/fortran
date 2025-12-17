### Program Yapısı

```fortran
program demo_merge
implicit none
integer :: tvals(2,3), fvals(2,3), answer(2,3)
logical :: mask(2,3)
integer :: i
integer :: k
logical :: chooseleft
```
*   **`program demo_merge`**: Programın başlangıcını belirtir ve adını verir.
*   **`implicit none`**: Bu ifade, tüm değişkenlerin açıkça (tip bildirimleriyle) bildirilmesini zorunlu kılar. Bu, hataları erken yakalamak için iyi bir programlama pratiğidir.
*   **Değişken Bildirimleri**:
    *   `integer :: tvals(2,3), fvals(2,3), answer(2,3)`: `tvals`, `fvals` ve `answer` adında, her biri 2 satır ve 3 sütundan oluşan tam sayı dizileri (matrisler) tanımlanır.
    *   `logical :: mask(2,3)`: `mask` adında, `true` veya `false` değerlerini tutacak, 2x3 boyutunda bir mantıksal dizi tanımlanır.
    *   `integer :: i`, `integer :: k`: `i` ve `k` adında basit tam sayı değişkenleri tanımlanır. `i` döngülerde kullanılmak üzere, `k` ise scalar `MERGE` örneği için.
    *   `logical :: chooseleft`: `true` veya `false` değerini tutacak, basit bir mantıksal değişken tanımlanır.

### `MERGE` Fonksiyonunun Scalar Kullanımı

```fortran
   ! Works with scalars
   k=5
   write(*,*)merge (1.0, 0.0, k > 0)
   k=-2
   write(*,*)merge (1.0, 0.0, k > 0)
```
*   Bu bölüm `MERGE` fonksiyonunun en basit kullanımını gösterir: üç bağımsız değişkenle (iki veri değeri ve bir mantıksal maske) scalar (tekil) değerler üzerinde çalışmak.
*   `merge (VALUET, VALUEF, MASK)`:
    *   Eğer `MASK` `true` ise `VALUET` değerini döndürür.
    *   Eğer `MASK` `false` ise `VALUEF` değerini döndürür.
*   İlk örnekte `k=5` olduğu için `k > 0` ifadesi `true` olur ve `1.0` değeri yazdırılır.
*   İkinci örnekte `k=-2` olduğu için `k > 0` ifadesi `false` olur ve `0.0` değeri yazdırılır.

### Dizi (Array) Başlatma

```fortran
   ! set up some simple arrays that all conform to the
   ! same shape
   tvals(1,:)=[  10, -60,  50 ]
   tvals(2,:)=[ -20,  40, -60 ]

   fvals(1,:)=[ 0, 3, 2 ]
   fvals(2,:)=[ 7, 4, 8 ]

   mask(1,:)=[ .true.,  .false., .true. ]
   mask(2,:)=[ .false., .false., .true. ]
```
*   `tvals` ve `fvals` adında iki adet 2x3 boyutunda tam sayı dizisi tanımlanır ve belirli değerlerle başlatılır.
*   `mask` adında 2x3 boyutunda bir mantıksal dizi tanımlanır ve `true`/`false` değerleriyle başlatılır. Bu diziler `MERGE` fonksiyonuyla birlikte kullanılacak.

### `MERGE` Fonksiyonunun Dizilerle Kullanımı (Açık Maske)

```fortran
   ! lets use the mask of specific values
   write(*,*)'mask of logicals'
   answer=merge( tvals, fvals, mask )
   call printme()
```
*   Burada `MERGE` fonksiyonu dizilerle kullanılır. İşlem eleman bazında yapılır.
*   `answer` dizisi, `tvals` ve `fvals` dizilerinden, `mask` dizisinin her elemanına göre seçilen değerlerle doldurulur.
    *   `mask(i,j)` `true` ise `answer(i,j) = tvals(i,j)`.
    *   `mask(i,j)` `false` ise `answer(i,j) = fvals(i,j)`.
*   Sonuç, `printme` alt programı çağrılarak ekrana yazdırılır.

### `MERGE` Fonksiyonunun Dizilerle Kullanımı (İfade Maske)

```fortran
   ! more typically the mask is an expression
   write(*, *)'highest values'
   answer=merge( tvals, fvals, tvals > fvals )
   call printme()

   write(*, *)'lowest values'
   answer=merge( tvals, fvals, tvals < fvals )
   call printme()
```
*   Bu bölümde, `mask` bağımsız değişkeni olarak doğrudan mantıksal bir ifade kullanılır. Bu, `MERGE` fonksiyonunun daha yaygın bir kullanım şeklidir.
*   **`highest values` (En Yüksek Değerler):**
    *   `tvals > fvals` ifadesi, `tvals` dizisinin elemanlarının `fvals` dizisinin karşılık gelen elemanlarından büyük olup olmadığını eleman bazında kontrol eden mantıksal bir dizi oluşturur.
    *   `MERGE` fonksiyonu, bu mantıksal dizi `true` olan yerlerde `tvals` elemanlarını, `false` olan yerlerde ise `fvals` elemanlarını `answer` dizisine yerleştirir. Yani, iki dizi arasında eleman bazında daha büyük olan değeri seçer.
*   **`lowest values` (En Düşük Değerler):**
    *   Benzer şekilde, `tvals < fvals` ifadesi maske olarak kullanılır.
    *   Bu, `tvals` ve `fvals` arasında eleman bazında daha küçük olan değeri seçer.

### Negatif Değerleri Sıfırlama Örneği

```fortran
   write(*, *)'zero out negative values'
   answer=merge( tvals, 0, tvals < 0)
   call printme()
```
*   Bu örnekte, `VALUET` olarak `tvals` dizisi, `VALUEF` olarak `0` (scalar bir değer), ve `MASK` olarak `tvals < 0` ifadesi kullanılır.
*   `tvals` dizisindeki eleman `0`dan küçükse (negatifse), `answer` dizisinin o elemanına `0` atanır.
*   `tvals` dizisindeki eleman `0`dan küçük değilse (sıfır veya pozitifse), `tvals`'ın kendisi `answer` dizisine atanır.
*   Böylece, `tvals` dizisindeki tüm negatif sayılar sıfırlanmış olur, pozitifler ve sıfırlar korunur.

### Scalar Mantıksal Değişkenle Dizi Seçimi

```fortran
   write(*, *)'binary choice'
   chooseleft=.false.
   write(*, '(3i4)')merge([1,2,3],[10,20,30],chooseleft)
   chooseleft=.true.
   write(*, '(3i4)')merge([1,2,3],[10,20,30],chooseleft)
```
*   Bu bölüm, `MERGE`'in maske olarak tek bir mantıksal değişken aldığında nasıl çalıştığını gösterir, ancak `VALUET` ve `VALUEF` olarak diziler verilmiştir.
*   `chooseleft=.false.` olduğunda, `MERGE` maskesi `false` olduğu için, `[10,20,30]` dizisi tamamen seçilir ve ekrana yazdırılır.
*   `chooseleft=.true.` olduğunda ise, `MERGE` maskesi `true` olduğu için, `[1,2,3]` dizisi tamamen seçilir ve ekrana yazdırılır.
*   Bu, bir koşula bağlı olarak iki diziden birini tamamen seçmek için kullanılabilir.

---

### Alt Program (`subroutine`)

```fortran
contains

subroutine printme()
      write(*, '(3i4)')(answer(i, :), i=1, size(answer, dim=1))
end subroutine printme
```
*   **`contains`**: Ana program içinde alt programların (subroutines ve functions) tanımlandığını belirtir.
*   **`subroutine printme()`**: `printme` adında parametresiz bir alt program tanımlanır.
*   **`write(*, '(3i4)')(answer(i, :), i=1, size(answer, dim=1))`**:
    *   Bu satır, `answer` dizisinin içeriğini ekrana düzenli bir formatta yazdırır.
    *   `'(3i4)'` format belirteci, her satırda 3 tam sayıyı, her birine 4 karakterlik yer ayırarak yazdırılmasını sağlar.
    *   `(answer(i, :), i=1, size(answer, dim=1))` bir implied do-loop'tur. Bu, `answer` dizisinin her satırını (yani `answer(1,:)`, `answer(2,:)`) sırayla seçip `write` komutuna besler.
    *   `size(answer, dim=1)` fonksiyonu, `answer` dizisinin ilk boyutunun (satır sayısı) uzunluğunu verir (bu durumda 2).

---

### Sonuç

Bu `demo_merge` programı, Fortran'ın `MERGE` içsel fonksiyonunun gücünü ve esnekliğini göstermektedir. Bu fonksiyon, hem scalar değerler hem de diziler üzerinde koşullu seçimler yapmak için çok kullanışlıdır ve özellikle sayısal programlamada belirli koşullara göre veri akışını kontrol etmek için sıkça kullanılır.