program iso_c_binding_add
  ! iso_c_binding ile C fonksiyonu çağırma örneği (tek ve basit).
  use, intrinsic :: iso_c_binding, only: c_double
  implicit none

  interface
    function add_double(a, b) bind(C, name='add_double') result(res)
      import :: c_double
      real(c_double), value :: a, b
      real(c_double) :: res
    end function add_double
  end interface

  print *, 'C add_double(1.25, 2.50) = ', add_double(1.25d0, 2.50d0)
end program iso_c_binding_add
