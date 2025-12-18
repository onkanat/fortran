module mandelbrot_constants
  ! Mandelbrot örneği için sabitler.
  use mandelbrot_types, only: dp
  implicit none
  private

  public :: imaginary_unit

  complex(dp), parameter :: imaginary_unit = (0.0_dp, 1.0_dp)
end module mandelbrot_constants
