program function_examples
  ! Demonstrating different Fortran function examples
  
  implicit none
  
  ! Function declarations
  real(kind=8) :: add_numbers
  real(kind=8) :: multiply_numbers
  real(kind=8) :: calculate_area
  real(kind=8) :: calculate_volume
  real(kind=8) :: maximum
  
  ! Main program
  print *, '=== Fortran Function Examples ==='
  
  ! Example 1: Addition Function
  print *, 'Example 1: Addition Function'
  print *, '10 + 20 = ', add_numbers(10.0_8, 20.0_8)
  print *, '5.5 + 3.2 = ', add_numbers(5.5_8, 3.2_8)
  print *
  
  ! Example 2: Area Calculation Function
  print *, 'Example 2: Area Calculation Function'
  print *, 'Area of rectangle (5 x 3) = ', calculate_area(5.0_8, 3.0_8), ' square units'
  print *, 'Area of circle (radius 2) = ', calculate_area(2.0_8, 0.0_8), ' square units'
  print *
  
  ! Example 3: Maximum Function
  print *, 'Example 3: Maximum Function'
  print *, 'Maximum of 15 and 25 = ', maximum(15.0_8, 25.0_8)
  print *, 'Maximum of -3.5 and -1.2 = ', maximum(-3.5_8, -1.2_8)
  
end program function_examples

! Add Numbers Function
real(kind=8) function add_numbers(a, b)
  implicit none
  ! Input arguments
  real(kind=8), intent(in) :: a, b
  
  ! Function body
  add_numbers = a + b
end function add_numbers

! Calculate Area Function (rectangle or circle)
real(kind=8) function calculate_area(length, width)
  implicit none
  ! Input arguments
  real(kind=8), intent(in) :: length, width
  
  ! Function body
  ! If width is zero, treat as circle with radius = length
  if (width == 0.0_8) then
     calculate_area = 3.1415926535897932384626433832795_8 * length * length  ! Circle area
  else
     calculate_area = length * width  ! Rectangle area
  end if
end function calculate_area

! Maximum Function
real(kind=8) function maximum(a, b)
  implicit none
  ! Input arguments
  real(kind=8), intent(in) :: a, b
  
  ! Function body
  if (a > b) then
     maximum = a
  else
     maximum = b
  end if
end function maximum
