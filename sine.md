# Sinüs Fonksiyonu Üretimi

Bu örnek, `nf` (neural-fortran) kütüphanesini kullanarak basit bir sinir ağı (neural network) ile sinüs fonksiyonunu nasıl üreteceğimizi gösterir. Program, bir sinir ağını eğitir ve ardından test verileri üzerinde ne kadar başarılı olduğunu değerlendirir.

## Kod: `sine.f90`

Aşağıdaki kod, `sine.f90` dosyasında bulunmaktadır.

```fortran
! sine.f90
! Bu program, 'nf' (neural-fortran) kütüphanesini kullanarak
! bir sinir ağını sinüs fonksiyonunu öğrenmesi için eğitir.
program sine
  ! 'nf' kütüphanesinden gerekli modülleri ve türleri içeri aktarır.
  ! dense: Tam bağlantılı katman (fully connected layer).
  ! input: Ağın giriş katmanı.
  ! network: Sinir ağı yapısını temsil eden tür.
  ! sgd: Stokastik Gradyan İniş (Stochastic Gradient Descent) optimizasyon algoritması.
  use nf, only: dense, input, network, sgd
  implicit none

  type(network) :: net ! Sinir ağı nesnesi
  real :: x(1), y(1) ! Eğitim için tek bir giriş (x) ve hedef (y) değeri
  real, parameter :: pi = 4 * atan(1.) ! Pi sabiti
  integer, parameter :: num_iterations = 100000 ! Eğitim döngüsü sayısı
  integer, parameter :: test_size = 30 ! Test veri seti boyutu
  real :: xtest(test_size), ytest(test_size), ypred(test_size) ! Test verileri ve tahminler
  integer :: i, n ! Döngü sayaçları

  print '("Sine training")'
  print '(60("="))'

  ! Sinir ağı modelini oluştur.
  ! 1 giriş nöronu, 5 nörondan oluşan bir gizli katman ve 1 çıkış nöronu.
  net = network([ &
    input(1), &
    dense(5), &
    dense(1) &
  ])

  ! Ağın yapısı hakkında bilgi yazdır.
  call net % print_info()

  ! Test veri setini oluştur. 0 ile 2*pi arasında 30 nokta.
  ! y değerleri, sinüs fonksiyonunun çıktısını [0, 1] aralığına normalize eder.
  xtest = [((i - 1) * 2 * pi / test_size, i = 1, test_size)]
  ytest = (sin(xtest) + 1) / 2

  ! Eğitim döngüsü
  do n = 0, num_iterations

    ! Rastgele bir giriş değeri (x) oluştur (0 ile 2*pi arasında).
    call random_number(x)
    x = x * 2 * pi
    ! Hedef değeri (y) hesapla ve [0, 1] aralığına normalize et.
    y = (sin(x) + 1) / 2

    ! İleri yayılım (forward propagation): Ağa girdiyi ver ve çıktıyı hesapla.
    call net % forward(x)
    ! Geriye yayılım (backward propagation): Hatayı hesapla ve gradyanları güncelle.
    call net % backward(y)
    ! Ağırlıkları güncelle (optimizasyon). SGD ve öğrenme oranı (learning rate) 1.0 kullanılır.
    call net % update(optimizer=sgd(learning_rate=1.))

    ! Her 10000 iterasyonda bir test veri seti üzerindeki ortalama karesel hatayı (MSE) yazdır.
    if (mod(n, 10000) == 0) then
      ypred = [(net % predict([xtest(i)]), i = 1, test_size)]
      print '(i0,1x,f9.6)', n, sum((ypred - ytest)**2) / size(ypred)
    end if

  end do

end program sine
```

## Açıklama

1.  **Kütüphane ve Modüller**: Program, `nf` kütüphanesinden `dense` (tam bağlantılı katman), `input` (giriş katmanı), `network` (ağ yapısı) ve `sgd` (optimizasyon algoritması) gibi bileşenleri kullanır.
2.  **Ağ Mimarisi**:
    -   `input(1)`: 1 nöronlu bir giriş katmanı.
    -   `dense(5)`: 5 nörondan oluşan bir gizli katman.
    -   `dense(1)`: 1 nöronlu bir çıkış katmanı.
    Bu mimari, tek bir sayı (bir açının radyan cinsinden değeri) alıp başka bir tek sayı (sinüs değerinin tahmini) üreten basit bir modeldir.
3.  **Veri Normalizasyonu**: Sinüs fonksiyonu `[-1, 1]` aralığında değerler üretir. Sinir ağının daha kararlı çalışması için bu değerler `(sin(x) + 1) / 2` formülüyle `[0, 1]` aralığına normalize edilir.
4.  **Eğitim Süreci**:
    -   `num_iterations` (100,000) kez tekrarlanan bir döngü içinde, program rastgele bir `x` değeri üretir ve buna karşılık gelen `y` (normalize edilmiş sinüs değeri) hedefini hesaplar.
    -   `net % forward(x)`: Mevcut ağ ağırlıklarıyla bir tahmin yapar.
    -   `net % backward(y)`: Tahmin ile hedef (`y`) arasındaki hatayı hesaplar ve bu hatayı kullanarak ağın ağırlıklarını nasıl güncelleyeceğini belirler (gradyanları hesaplar).
    -   `net % update(...)`: `sgd` (Stokastik Gradyan İniş) optimizasyon algoritmasını kullanarak ağın ağırlıklarını günceller.
5.  **Değerlendirme**: Her 10,000 iterasyonda, ağın performansı önceden hazırlanmış `xtest` veri seti üzerinde ölçülür. Tahminler (`ypred`) ile gerçek değerler (`ytest`) arasındaki Ortalama Karesel Hata (Mean Squared Error - MSE) hesaplanır ve ekrana yazdırılır. İterasyon sayısı arttıkça bu hata değerinin düşmesi beklenir.

## Derleme ve Çalıştırma

Bu programı derlemek için `neural-fortran` kütüphanesinin sisteminizde kurulu olması gerekir. Kurulum ve derleme talimatları için [neural-fortran GitHub deposunu](https://github.com/modern-fortran/neural-fortran) ziyaret edebilirsiniz.

Eğer kütüphane doğru bir şekilde kurulmuşsa, programı aşağıdaki gibi derleyebilirsiniz:

```sh
gfortran sine.f90 -o sine $(nf-config --fflags --libs)
```

Ardından çalıştırın:
```sh
./sine
```