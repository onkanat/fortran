program quadratic
  ! Modern Fortran örneği: İkinci dereceden denklem çözümü
  !
  ! Denklem: a*x^2 + b*x + c = 0
  ! Ayırt edici (discriminant): Δ = b^2 - 4ac
  !
  ! Δ > 0  : iki farklı gerçek kök
  ! Δ = 0  : tek (tekrarlı) gerçek kök
  ! Δ < 0  : iki karmaşık kök
  !
  implicit none

  real(kind=8) :: a_coef, b_coef, c_coef
  real(kind=8) :: disc
  real(kind=8) :: root1_r, root2_r
  complex(kind=8) :: root1_c, root2_c
  real(kind=8) :: tol
  integer :: io_stat
  character(len=200) :: io_msg

  print *, 'İkinci Dereceden Denklem Çözücü'
  print *, 'a*x^2 + b*x + c = 0'
  print *, 'a, b, c değerlerini giriniz (ör: 1 5 6):'

  read (*,*, iostat=io_stat, iomsg=io_msg) a_coef, b_coef, c_coef
  if (io_stat /= 0) then
     print *, 'Hata: Girdi okunamadı. Lütfen sayısal değerler giriniz.'
     print *, 'Detay: ', trim(io_msg)
     stop 1
  end if

  if (a_coef == 0.0_8) then
     print *, 'Hata: a = 0 olamaz (denklem ikinci dereceden değildir).'
     stop 1
  end if

  disc = b_coef*b_coef - 4.0_8*a_coef*c_coef

  ! Gerçek sayılarda == 0 karşılaştırması hassasiyet nedeniyle riskli olabilir.
  ! Bu nedenle küçük bir tolerans ile “sıfıra yakın” kontrolü yapılır.
  tol = 1.0e-12_8 * max(1.0_8, abs(b_coef*b_coef), abs(4.0_8*a_coef*c_coef))

  if (disc > tol) then
     root1_r = (-b_coef + sqrt(disc)) / (2.0_8*a_coef)
     root2_r = (-b_coef - sqrt(disc)) / (2.0_8*a_coef)

     print *, 'Δ > 0: İki farklı gerçek kök:'
     write (*,'(A,F12.6)') 'Kök 1 = ', root1_r
     write (*,'(A,F12.6)') 'Kök 2 = ', root2_r

  else if (abs(disc) <= tol) then
     root1_r = (-b_coef) / (2.0_8*a_coef)

     print *, 'Δ ≈ 0: Tek (tekrarlı) gerçek kök:'
     write (*,'(A,F12.6)') 'Kök = ', root1_r

  else
     root1_c = (-b_coef + sqrt(cmplx(disc, 0.0_8, kind=8))) / (2.0_8*a_coef)
     root2_c = (-b_coef - sqrt(cmplx(disc, 0.0_8, kind=8))) / (2.0_8*a_coef)

     print *, 'Δ < 0: İki karmaşık kök (format: (gerçek, sanal)):'
     print *, 'Kök 1 = ', root1_c
     print *, 'Kök 2 = ', root2_c
  end if

end program quadratic
