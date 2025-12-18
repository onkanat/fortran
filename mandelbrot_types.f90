module mandelbrot_types
  ! Mandelbrot örneği için tür (kind) tanımları.
  use, intrinsic :: iso_fortran_env, only: real64
  implicit none
  private

  public :: dp

  integer, parameter :: dp = real64
end module mandelbrot_types
