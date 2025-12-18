module measurement_series_mod
  ! Derived type + allocatable bileşen + type-bound procedure örneği.
  !
  ! Not: type-bound prosedürlerin doğru bağlanması için prosedürlerin modül
  ! kapsamında (module procedure) olması en temiz yaklaşımdır.
  use, intrinsic :: iso_fortran_env, only: real64
  implicit none
  private

  public :: measurement_series

  type :: measurement_series
    real(real64), allocatable :: values(:)
  contains
    procedure :: init_from_array
    procedure :: mean
    procedure :: min_value
    procedure :: max_value
  end type measurement_series

contains

  subroutine init_from_array(self, arr)
    class(measurement_series), intent(inout) :: self
    real(real64), intent(in) :: arr(:)

    if (allocated(self%values)) deallocate(self%values)
    allocate(self%values(size(arr)))
    self%values = arr
  end subroutine init_from_array

  pure real(real64) function mean(self) result(m)
    class(measurement_series), intent(in) :: self

    if (.not. allocated(self%values)) then
      m = 0.0_real64
    else if (size(self%values) == 0) then
      m = 0.0_real64
    else
      m = sum(self%values) / real(size(self%values), kind=real64)
    end if
  end function mean

  pure real(real64) function min_value(self) result(v)
    class(measurement_series), intent(in) :: self

    if (.not. allocated(self%values) .or. size(self%values) == 0) then
      v = 0.0_real64
    else
      v = minval(self%values)
    end if
  end function min_value

  pure real(real64) function max_value(self) result(v)
    class(measurement_series), intent(in) :: self

    if (.not. allocated(self%values) .or. size(self%values) == 0) then
      v = 0.0_real64
    else
      v = maxval(self%values)
    end if
  end function max_value

end module measurement_series_mod

program measurement_series_demo
  use, intrinsic :: iso_fortran_env, only: real64
  use measurement_series_mod, only: measurement_series
  implicit none

  type(measurement_series) :: series
  real(real64) :: data(6)

  data = [1.0_real64, 2.0_real64, 2.5_real64, -1.0_real64, 10.0_real64, 3.0_real64]
  call series%init_from_array(data)

  print *, '=== measurement_series Demo ==='
  print *, 'mean = ', series%mean()
  print *, 'min  = ', series%min_value()
  print *, 'max  = ', series%max_value()
end program measurement_series_demo
