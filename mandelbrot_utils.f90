module mandelbrot_utils
  ! Mandelbrot örneği için yardımcı rutinler.
  use mandelbrot_types, only: dp
  implicit none
  private

  public :: linspace
  public :: meshgrid
  public :: savetxt

contains

  function linspace(start_value, stop_value, n) result(values)
    real(dp), intent(in) :: start_value, stop_value
    integer, intent(in) :: n
    real(dp) :: values(n)
    integer :: i

    if (n <= 0) return
    if (n == 1) then
      values(1) = start_value
      return
    end if

    do i = 1, n
      values(i) = start_value + (stop_value - start_value) * real(i - 1, dp) / real(n - 1, dp)
    end do
  end function linspace

  subroutine meshgrid(x_in, y_in, x_out, y_out)
    real(dp), intent(in) :: x_in(:), y_in(:)
    real(dp), intent(out) :: x_out(size(x_in), size(y_in))
    real(dp), intent(out) :: y_out(size(x_in), size(y_in))

    integer :: i, j

    do j = 1, size(y_in)
      do i = 1, size(x_in)
        x_out(i, j) = x_in(i)
        y_out(i, j) = y_in(j)
      end do
    end do
  end subroutine meshgrid

  subroutine savetxt(filename, data)
    character(len=*), intent(in) :: filename
    real(dp), intent(in) :: data(:, :)

    integer :: file_unit
    integer :: ios
    character(len=200) :: iomsg
    integer :: j

    open(newunit=file_unit, file=filename, status='replace', action='write', iostat=ios, iomsg=iomsg)
    if (ios /= 0) then
      write (*,*) 'Hata: Dosya açılamadı: ', trim(filename)
      write (*,*) 'Detay: ', trim(iomsg)
      stop 1
    end if

    ! Numpy loadtxt ile uyumlu olması için satır satır yaz.
    do j = 1, size(data, dim=2)
      write (file_unit, *) data(:, j)
    end do

    close(file_unit)
  end subroutine savetxt

end module mandelbrot_utils
