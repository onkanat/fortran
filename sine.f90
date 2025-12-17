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
