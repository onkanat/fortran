# Mandelbrot Set Oluşturucu

Bu doküman, `Mandelbrot.f90` programının nasıl çalıştığını, bağımlı olduğu modülleri ve üretilen verinin nasıl görselleştirileceğini açıklar.

## Fortran Kodunun Açıklaması (`Mandelbrot.f90`)

Bu program, Mandelbrot kümesini hesaplar ve sonucu iki ayrı dosyaya kaydeder.

```fortran
program Mandelbrot
use types, only: dp
use constants, only: I
use utils, only: savetxt, linspace, meshgrid
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
c = x + I*y
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
call savetxt("fractal.dat", log(real(fractal, dp)))
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

`Mandelbrot.f90` programının derlenebilmesi için aşağıdaki üç modülün de oluşturulması gerekir.

### 1. `types.f90`

Bu modül, çift duyarlıklı (`double precision`) sayılar için bir tür (kind) parametresi tanımlar. Bu, programın taşınabilirliğini ve hassasiyet kontrolünü artırır.

```fortran
! types.f90
module types
    implicit none
    ! Çift duyarlıklı (double precision) reel sayılar için tür parametresi
    integer, parameter :: dp = kind(0.0d0)
end module types
```

### 2. `constants.f90`

Bu modül, programda kullanılacak sabitleri (örneğin, sanal birim `i`) tanımlar.

```fortran
! constants.f90
module constants
    use types, only: dp
    implicit none
    private
    public :: I

    ! Sanal birim i = sqrt(-1)
    complex(dp), parameter :: I = (0.0_dp, 1.0_dp)
end module constants
```

### 3. `utils.f90`

Bu modül, ana programda kullanılan yardımcı alt programları (`linspace`, `meshgrid`, `savetxt`) içerir.

```fortran
! utils.f90
module utils
    use types, only: dp
    implicit none
    private
    public :: linspace, meshgrid, savetxt

contains

    ! Belirli bir aralıkta eşit aralıklı sayılar dizisi oluşturur.
    function linspace(start, stop, n) result(res)
        real(dp), intent(in) :: start, stop
        integer, intent(in) :: n
        real(dp), dimension(n) :: res
        integer :: i
        do i = 1, n
            res(i) = start + (stop - start) * real(i - 1, dp) / real(n - 1, dp)
        end do
    end function linspace

    ! İki 1D diziden bir 2D koordinat ızgarası oluşturur.
    subroutine meshgrid(x_in, y_in, x_out, y_out)
        real(dp), dimension(:), intent(in) :: x_in, y_in
        real(dp), dimension(size(x_in), size(y_in)), intent(out) :: x_out, y_out
        integer :: i, j
        do j = 1, size(y_in)
            do i = 1, size(x_in)
                x_out(i, j) = x_in(i)
                y_out(i, j) = y_in(j)
            end do
        end do
    end subroutine meshgrid

    ! Bir 2D reel diziyi metin dosyasına kaydeder.
    subroutine savetxt(filename, data)
        character(len=*), intent(in) :: filename
        real(dp), dimension(:, :), intent(in) :: data
        integer :: file_unit
        open(newunit=file_unit, file=filename, status="replace", action="write")
        write(file_unit, *) data
        close(file_unit)
    end subroutine savetxt

end module utils
```
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
