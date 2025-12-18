module statistics_utils
  ! Basit istatistik fonksiyonları: mean/stddev.
  !
  ! Gösterilenler:
  ! - module, public/private
  ! - pure fonksiyonlar
  ! - generic interface (mean/stddev) ile overload
  use, intrinsic :: iso_fortran_env, only: real64, int32
  implicit none
  private

  public :: dp
  public :: mean, stddev

  integer, parameter :: dp = real64

  interface mean
    module procedure mean_real
    module procedure mean_int
  end interface mean

  interface stddev
    module procedure stddev_real
  end interface stddev

contains

  pure real(dp) function mean_real(x) result(m)
    real(dp), intent(in) :: x(:)
    if (size(x) == 0) then
      m = 0.0_dp
    else
      m = sum(x) / real(size(x), kind=dp)
    end if
  end function mean_real

  pure real(dp) function mean_int(x) result(m)
    integer(int32), intent(in) :: x(:)
    if (size(x) == 0) then
      m = 0.0_dp
    else
      m = sum(real(x, kind=dp)) / real(size(x), kind=dp)
    end if
  end function mean_int

  pure real(dp) function stddev_real(x) result(s)
    real(dp), intent(in) :: x(:)
    real(dp) :: m

    if (size(x) <= 1) then
      s = 0.0_dp
      return
    end if

    m = mean_real(x)
    s = sqrt(sum((x - m)**2) / real(size(x) - 1, kind=dp))
  end function stddev_real

end module statistics_utils
