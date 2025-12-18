# Mandelbrot Set Oluşturucu

Bu doküman, `Mandelbrot.f90` programının nasıl çalıştığını, bağımlı olduğu modülleri ve üretilen verinin nasıl görselleştirileceğini açıklar.

## Derleme ve Çalıştırma

Bu örnek modüler olduğu için, ana programla birlikte modülleri de derlemek gerekir:

```sh
gfortran mandelbrot_types.f90 mandelbrot_constants.f90 mandelbrot_utils.f90 Mandelbrot.f90 -o mandelbrot
./mandelbrot
```

## Fortran Kodunun Açıklaması (`Mandelbrot.f90`)

Bu program, Mandelbrot kümesini hesaplar ve sonucu iki ayrı dosyaya kaydeder.

```fortran
program Mandelbrot
use mandelbrot_types, only: dp
use mandelbrot_constants, only: imaginary_unit
use mandelbrot_utils, only: savetxt, linspace, meshgrid
implicit none

! Parametreler ve Değişkenler
integer, parameter :: ITERATIONS = 100 ! İterasyon sayısı
integer, parameter :: DENSITY = 1000 ! Izgara yoğunluğu
real(dp) :: x_min, x_max, y_min, y_max ! Karmaşık düzlemin sınırları
real(dp), dimension(DENSITY, DENSITY) :: x, y
complex(dp), dimension(DENSITY, DENSITY) :: c, z
integer, dimension(DENSITY, DENSITY) :: fractal
integer :: n

! 1. Karmaşık Düzlemi Ayarlama
x_min = -2.68_dp; x_max = 1.32_dp
y_min = -1.5_dp; y_max = 1.5_dp

! 2. Izgara (Grid) Oluşturma
call meshgrid(linspace(x_min, x_max, DENSITY), &
    linspace(y_min, y_max, DENSITY), x, y)
c = x + imaginary_unit*y
z = c
fractal = 255 ! Başlangıçta tüm pikselleri "içeride" olarak ayarla

! 3. Mandelbrot İterasyonu
do n = 1, ITERATIONS
    print "('Iteration ', i0)", n
    ! |z| <= 10 koşulunu sağlayan noktalar için iterasyonu uygula
    where (abs(z) <= 10) z = z**2 + c
    ! Henüz "dışarıda" olarak işaretlenmemiş ve |z|>10 olan noktaları,
    ! kaçtıkları iterasyon sayısına göre renklendir.
    where (fractal == 255 .and. abs(z) > 10) fractal = 254 * (n-1) / ITERATIONS
end do

! 4. Sonuçları Kaydetme
print *, "Saving..."
call savetxt("fractal.dat", log(1.0_dp + real(fractal, dp)))
call savetxt("coord.dat", reshape([x_min, x_max, y_min, y_max], [4, 1]))
end program
```

### Çalışma Mantığı

1.  **Karmaşık Düzlem:** İlk olarak, Mandelbrot kümesinin hesaplanacağı karmaşık düzlemin sınırları (`x_min`, `x_max`, `y_min`, `y_max`) belirlenir.
2.  **Izgara Oluşturma:** `linspace` ve `meshgrid` yardımcı fonksiyonları ( `utils` modülünden) kullanılarak bu sınırlar içinde `DENSITY`x`DENSITY` boyutunda bir karmaşık sayı ızgarası (`c`) oluşturulur. Her bir nokta, bir `c` karmaşık sayısını temsil eder.
3.  **İterasyon:** Program, her bir `c` noktası için `z = z**2 + c` formülünü `ITERATIONS` defa tekrarlar.
    -   `where (abs(z) <= 10)`: Bu satır, yalnızca `z`'nin büyüklüğü (orijine uzaklığı) 10'dan küçük veya eşit olan noktalar için hesaplamayı sürdürür. Bir noktanın büyüklüğü bu sınırı aştığında, o noktanın "kaçtığı" kabul edilir ve o nokta için iterasyon durur.
    -   `where (fractal == 255 .and. abs(z) > 10)`: Bu satır, "kaçan" noktaları renklendirir. Bir nokta ilk defa sınırı aştığında, `fractal` dizisindeki o pikselin değeri, kaçışın gerçekleştiği `n` (iterasyon sayısı) değerine bağlı olarak güncellenir. `255` başlangıç değeri, henüz kaçmamış noktaları temsil eder.
4.  **Kaydetme:**
    -   `fractal.dat`: İterasyonlar bittikten sonra, her piksel için hesaplanan renk değerlerinin logaritması alınır ve bu 2D dizi `fractal.dat` dosyasına kaydedilir. Logaritma, daha iyi bir görsel kontrast elde etmek için kullanılır.
    -   `coord.dat`: Görselleştirme sırasında kullanılmak üzere düzlemin köşe koordinatları `coord.dat` dosyasına kaydedilir.

---

## Gerekli Modüller

`Mandelbrot.f90` programının derlenebilmesi için aşağıdaki üç modülün de bulunması gerekir.

### 1. `mandelbrot_types.f90`

Bu modül, çift duyarlıklı (`double precision`) sayılar için bir tür (kind) parametresi tanımlar. Bu, programın taşınabilirliğini ve hassasiyet kontrolünü artırır.

Bu repo içinde bu modül `iso_fortran_env` üzerinden `real64` kullanır.

### 2. `mandelbrot_constants.f90`

Bu modül, programda kullanılacak sabitleri (örneğin, sanal birim `i`) tanımlar.

Bu modül sanal birimi `imaginary_unit` olarak dışarıya açar.

### 3. `mandelbrot_utils.f90`

Bu modül, ana programda kullanılan yardımcı alt programları (`linspace`, `meshgrid`, `savetxt`) içerir.

Bu modül, `linspace/meshgrid/savetxt` yardımcı rutinlerini içerir. `savetxt` satır satır yazdığı için Python tarafında `numpy.loadtxt` ile okunması kolaydır.
---

## Python ile Görselleştirme

Fortran programı çalıştırıldıktan sonra oluşan `fractal.dat` ve `coord.dat` dosyalarını kullanarak Mandelbrot kümesini görselleştirmek için aşağıdaki Python betiğini kullanabilirsiniz. Bu betik, `numpy` ve `matplotlib` kütüphanelerini gerektirir.

```python
from numpy import loadtxt
import matplotlib.pyplot as plt

# Fortran tarafından oluşturulan verileri yükle
fractal = loadtxt("fractal.dat")
x_min, x_max, y_min, y_max = loadtxt("coord.dat")

# Matplotlib ile veriyi görselleştir
plt.imshow(fractal, cmap=plt.cm.hot,
            extent=(x_min, x_max, y_min, y_max))
plt.title('Mandelbrot Set')
plt.xlabel('Re(z)')
plt.ylabel('Im(z)')

# Sonucu bir PNG dosyası olarak kaydet
plt.savefig("mandelbrot.png")

print("Mandelbrot görseli 'mandelbrot.png' olarak kaydedildi.")
```

Bu betik çalıştırıldığında, projenizin bulunduğu dizinde `mandelbrot.png` adında bir görüntü dosyası oluşturulacaktır.
