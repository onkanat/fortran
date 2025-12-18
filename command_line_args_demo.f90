program command_line_args_demo
  ! Komut satırı argümanları örneği:
  !   ./command_line_args_demo 20
  ! gibi bir kullanım ile N adet rastgele sayı üretip ortalamasını hesaplar.
  use, intrinsic :: iso_fortran_env, only: real64
  implicit none

  integer :: argc
  character(len=128) :: arg
  integer :: ios
  character(len=200) :: iomsg
  integer :: n
  integer :: i
  real(real64) :: x, sum_x

  n = 10
  argc = command_argument_count()
  if (argc >= 1) then
    call get_command_argument(1, arg)
    read(arg, *, iostat=ios, iomsg=iomsg) n
    if (ios /= 0 .or. n < 0) then
      print *, 'Hata: N için geçersiz argüman. Detay: ', trim(iomsg)
      print *, 'Kullanim: ./command_line_args_demo [N]'
      stop 1
    end if
  end if

  call random_seed() ! basit kullanım: derleyicinin/OS'in seed'ine bırak

  sum_x = 0.0_real64
  do i = 1, n
    call random_number(x)
    sum_x = sum_x + x
  end do

  if (n == 0) then
    print *, 'N=0 olduğu için ortalama hesaplanmadı.'
  else
    print *, 'N = ', n
    print *, 'Ortalama (0..1 uniform) = ', sum_x / real(n, kind=real64)
  end if
end program command_line_args_demo
