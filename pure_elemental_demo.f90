program pure_elemental_demo
  ! pure/elemental fonksiyonlarla dizi üzerinde eleman-bazlı işlem örneği.
  implicit none

  real(kind=8) :: x(5)
  real(kind=8) :: y(5)

  x = [-2.0_8, -0.5_8, 0.0_8, 1.5_8, 3.0_8]

  ! elemental fonksiyon: skaler gibi yazılır, diziye uygulanınca eleman-bazlı çalışır
  y = clamp(x, 0.0_8, 1.0_8)

  print *, 'x = ', x
  print *, 'y = clamp(x, 0..1) = ', y

contains

  pure elemental real(kind=8) function clamp(value, lo, hi) result(out)
    implicit none
    real(kind=8), intent(in) :: value, lo, hi

    if (value < lo) then
      out = lo
    else if (value > hi) then
      out = hi
    else
      out = value
    end if
  end function clamp

end program pure_elemental_demo
