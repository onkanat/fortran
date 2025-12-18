program function_examples
  ! Fonksiyon örnekleri: internal (contains) fonksiyonlarla Modern Fortran yaklaşımı.
  !
  ! Not: Internal fonksiyonlar kullanıldığında "explicit interface" otomatik sağlanır.
  implicit none

  real(kind=8), parameter :: pi = 3.141592653589793_8

  print *, '=== Fortran Fonksiyon Örnekleri ==='

  print *, 'Örnek 1: Toplama Fonksiyonu'
  print *, '10 + 20 = ', add_numbers(10.0_8, 20.0_8)
  print *, '5.5 + 3.2 = ', add_numbers(5.5_8, 3.2_8)
  print *

  print *, 'Örnek 2: Alan Hesabı Fonksiyonları'
  print *, 'Dikdörtgen alanı (5 x 3) = ', rectangle_area(5.0_8, 3.0_8)
  print *, 'Daire alanı (yarıçap 2)  = ', circle_area(2.0_8)
  print *

  print *, 'Örnek 3: Maksimum Fonksiyonu'
  print *, 'Maksimum (15, 25) = ', maximum_value(15.0_8, 25.0_8)
  print *, 'Maksimum (-3.5, -1.2) = ', maximum_value(-3.5_8, -1.2_8)

contains

  real(kind=8) function add_numbers(a, b) result(sum_value)
    implicit none
    real(kind=8), intent(in) :: a, b
    sum_value = a + b
  end function add_numbers

  real(kind=8) function rectangle_area(length, width) result(area)
    implicit none
    real(kind=8), intent(in) :: length, width
    area = length * width
  end function rectangle_area

  real(kind=8) function circle_area(radius) result(area)
    implicit none
    real(kind=8), intent(in) :: radius
    area = pi * radius * radius
  end function circle_area

  real(kind=8) function maximum_value(a, b) result(max_value)
    implicit none
    real(kind=8), intent(in) :: a, b

    if (a > b) then
      max_value = a
    else
      max_value = b
    end if
  end function maximum_value

end program function_examples
