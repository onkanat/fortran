program sos_difference
  ! Modern Fortran örneği: Döngüler (counter controlled)
  !
  ! Amaç:
  !   İlk N doğal sayının karelerinin toplamı ile
  !   bu sayıların toplamının karesi arasındaki farkı hesaplamak.
  !
  !   sum_of_squares = 1^2 + 2^2 + ... + N^2
  !   square_of_sum  = (1 + 2 + ... + N)^2
  !   difference     = square_of_sum - sum_of_squares
  !
  implicit none

  integer :: i, n
  integer :: sum_of_squares, sum, square_of_sum, difference
  integer :: io_stat
  character(len=200) :: io_msg

  write (*,*) 'Ornek Program'
  write (*,*) 'Karelerin toplami ile toplamın karesi arasindaki fark'
  write (*,*)
  write (*,*) 'N degerini girin (N >= 1):'

  read (*,*, iostat=io_stat, iomsg=io_msg) n
  if (io_stat /= 0) then
     print *, 'Hata: Girdi okunamadi. Lutfen bir tamsayi girin.'
     print *, 'Detay: ', trim(io_msg)
     stop 1
  end if

  if (n < 1) then
     print *, 'Hata: N en az 1 olmalidir.'
     stop 1
  end if

  sum_of_squares = 0
  sum = 0

  do i = 1, n
     sum_of_squares = sum_of_squares + i**2
     sum = sum + i
  end do

  square_of_sum = sum**2
  difference = square_of_sum - sum_of_squares

  write (*,'(A,I0)') 'N = ', n
  write (*,'(A,I0)') 'Karelerin toplami = ', sum_of_squares
  write (*,'(A,I0)') 'Toplamin karesi  = ', square_of_sum
  write (*,'(A,I0)') 'Fark             = ', difference

end program sos_difference
