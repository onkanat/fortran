program do_concurrent_demo
  ! Basit ve gerçekçi paralelleştirilebilir döngü örneği.
  !
  ! do concurrent, iterasyonların birbirinden bağımsız olduğunu ifade eder.
  ! Derleyici bunu vektörleştirebilir veya paralelleştirebilir.
  use, intrinsic :: iso_fortran_env, only: real64
  implicit none

  integer, parameter :: n = 1000000
  real(real64), allocatable :: x(:), y(:)
  integer :: i

  allocate(x(n), y(n))

  ! Girdi dizisi
  do i = 1, n
    x(i) = real(i, kind=real64) * 1.0e-6_real64
  end do

  ! Bağımsız dönüşüm (embarrassingly parallel)
  do concurrent (i = 1:n)
    y(i) = f(x(i))
  end do

  print *, 'n = ', n
  print *, 'min(y) = ', minval(y)
  print *, 'max(y) = ', maxval(y)
  print *, 'mean(y) = ', sum(y) / real(n, kind=real64)

  deallocate(x, y)

contains

  pure real(real64) function f(t) result(out)
    real(real64), intent(in) :: t
    out = sin(10.0_real64 * t) + 0.5_real64 * cos(3.0_real64 * t)
  end function f

end program do_concurrent_demo
