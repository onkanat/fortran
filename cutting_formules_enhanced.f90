program cutting_formules_enhanced
  ! Modern Fortran örneği: talaş kaldırma formülü (Cutting speed - Vc)
  !
  ! Açıklama (Türkçe):
  ! Bu program kullanıcının verdiği çap (D, mm) ve devir (n, rpm)
  ! değerlerine göre kesme hızını (Vc, m/min) hesaplar.
  !
  ! Ayrıca:
  ! Kesme hızı (Vc, m/min) ve çap (D, mm) verildiğinde devir (n, rpm) hesaplar.
  !
  ! Formüller:
  !   Vc = (pi * D * n) / 1000
  !   n = (Vc * 1000) / (pi * D)
  !
  ! Burada:
  !   - D milimetre (mm) cinsindendir
  !   - n devir/dakika (rpm)
  !   - Vc metre/dakika (m/min) olarak sonuç verir
  !
  ! Derleme (örnek):
  !   gfortran -o cutting_formules_enhanced cutting_formules_enhanced.f90
  !
  ! Çalıştırma:
  !   ./cutting_formules_enhanced
  !
  implicit none

  ! Yüksek duyarlık için double precision (kind=8) kullanıyoruz.
  real(kind=8), parameter :: pi = 3.1415926535897932384626433832795_8
  real(kind=8) :: Vc      ! kesme hızı (m/min)
  real(kind=8) :: D       ! çap (mm)
  real(kind=8) :: n       ! devir (rpm)
  integer :: choice      ! kullanıcı seçimine göre hangi işlemi yapacak

  ! Kullanıcıya seçim yapmasını sor
  print *, 'Kesme Hızı Hesaplama Programı'
  print *, '1 - Çap ve Devir -> Kesme Hızı (Vc)'
  print *, '2 - Kesme Hızı ve Çap -> Devir (n)'
  print *, 'Lütfen seçim yapınız (1 veya 2):'
  read  (*,*) choice

  ! Seçime göre işlemi yap
  if (choice == 1) then
     ! Kesme hızını hesapla: D (mm), n (rpm) -> Vc (m/min)
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

     ! Kesme hızını hesapla
     Vc = (pi * D * n) / 1000.0_8

     ! Sonucu kullanıcıya göster
     write (*,'(A,F10.3,A)') 'Kesme hızı Vc = ', Vc, ' m/min'
     print *, 'Not: D (mm), n (rpm) girdisine göre Vc m/min cinsinden hesaplanır.'
  else if (choice == 2) then
     ! Devir hesapla: Vc (m/min), D (mm) -> n (rpm)
     print *, 'Kesme Hızı (Vc) [m/min] giriniz:'
     read  (*,*) Vc
     print *, 'Çap (D) [mm] giriniz:'
     read  (*,*) D

     ! Basit giriş doğrulaması
     if (Vc <= 0.0_8) then
        print *, 'Hata: Kesme hızı pozitif bir değer olmalıdır.'
        stop 1
     end if
     if (D <= 0.0_8) then
        print *, 'Hata: Çap pozitif bir değer olmalıdır.'
        stop 1
     end if

     ! Devir hesapla
     n = (Vc * 1000.0_8) / (pi * D)

     ! Sonucu kullanıcıya göster
     write (*,'(A,F10.3,A)') 'Devir (n) = ', n, ' rpm'
     print *, 'Not: Vc (m/min), D (mm) girdisine göre n rpm cinsinden hesaplanır.'
  else
     print *, 'Geçersiz seçim. Lütfen 1 veya 2 giriniz.'
     stop 1
  end if

end program cutting_formules_enhanced
