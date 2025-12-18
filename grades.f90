program grades
  ! Modern Fortran örneği: Not harfi atama (select case)
  !
  ! Kullanıcıdan 3 sınav notu (0-100) alınır, ortalaması hesaplanır.
  ! Ortalama en yakın tamsayıya yuvarlanır (nint) ve harf notu belirlenir.
  !
  implicit none

  real(kind=8) :: test1, test2, test3
  real(kind=8) :: average_score
  integer :: test_ave
  integer :: io_stat
  character(len=200) :: io_msg

  write (*,*) 'Not Atama Programı'
  write (*,*)
  write (*,*) 'Test 1, Test 2 ve Test 3 notlarını giriniz (0-100):'

  read (*,*, iostat=io_stat, iomsg=io_msg) test1, test2, test3
  if (io_stat /= 0) then
     print *, 'Hata: Girdi okunamadı. Lütfen sayısal değerler giriniz.'
     print *, 'Detay: ', trim(io_msg)
     stop 1
  end if

  if (test1 < 0.0_8 .or. test1 > 100.0_8) then
     print *, 'Hata: Test 1 notu 0 ile 100 arasında olmalıdır.'
     stop 1
  end if

  if (test2 < 0.0_8 .or. test2 > 100.0_8) then
     print *, 'Hata: Test 2 notu 0 ile 100 arasında olmalıdır.'
     stop 1
  end if

  if (test3 < 0.0_8 .or. test3 > 100.0_8) then
     print *, 'Hata: Test 3 notu 0 ile 100 arasında olmalıdır.'
     stop 1
  end if

  average_score = (test1 + test2 + test3) / 3.0_8
  test_ave = nint(average_score)

  write (*,'(A,F6.2)') 'Ortalama (real) = ', average_score
  write (*,'(A,I0)')   'Ortalama (nint) = ', test_ave

  select case (test_ave)
  case (90:)
     write (*,*) 'Harf Notu: A'
  case (80:89)
     write (*,*) 'Harf Notu: B'
  case (70:79)
     write (*,*) 'Harf Notu: C'
  case (60:69)
     write (*,*) 'Harf Notu: D'
  case (:59)
     write (*,*) 'Harf Notu: F'
  end select

end program grades
