program cutting_formules
  ! Modern Fortran örneği: talaş kaldırma formülü (Cutting speed - Vc)
  !
  ! Açıklama (Türkçe):
  ! Bu program kullanıcının verdiği çap (D, mm) ve devir (n, rpm)
  ! değerlerine göre kesme hızını (Vc, m/min) hesaplar.
  !
  ! Formül:
  !   Vc = (pi * D * n) / 1000
  ! Burada:
  !   - D milimetre (mm) cinsindendir
  !   - n devir/dakika (rpm)
  !   - Vc metre/dakika (m/min) olarak sonuç verir
  !
  ! Derleme (örnek):
  !   gfortran -o cutting_formules cutting_formules.f90
  !
  ! Çalıştırma:
  !   ./cutting_formules
  !
  implicit none

  ! Yüksek duyarlık için double precision (kind=8) kullanıyoruz.
  real(kind=8), parameter :: pi = 3.1415926535897932384626433832795_8
  real(kind=8) :: Vc      ! kesme hızı (m/min)
  real(kind=8) :: D       ! çap (mm)
  real(kind=8) :: n       ! devir (rpm)

  ! Kullanıcıdan değerleri al
  print *, 'Çap (D) [mm] giriniz:'
  read  (*,*) D
  print *, 'Devir (n) [rpm] giriniz:'
  read  (*,*) n

  ! Basit giriş doğrulaması
  if (D <= 0.0_8) then
     print *, 'Hata: Çap pozitif bir değer olmalıdır.'
     stop 1
  end if
  if (n <= 0.0_8) then
     print *, 'Hata: Devir (rpm) pozitif bir değer olmalıdır.'
     stop 1
  end if

  ! Kesme hızını hesapla (D [mm], n [rpm] -> Vc [m/min])
  Vc = (pi * D * n) / 1000.0_8

  ! Sonucu kullanıcıya göster
  write (*,'(A,F10.3,A)') 'Kesme hızı Vc = ', Vc, ' m/min'

  ! İsteğe bağlı: hesaplama ile ilgili kısa bilgi
  print *, 'Not: D (mm), n (rpm) girdisine göre Vc m/min cinsinden hesaplanır.'

end program cutting_formules
