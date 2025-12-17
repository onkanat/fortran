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
