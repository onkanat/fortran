program function_demo
  ! Function example: calculate square of a number
  implicit none
  
  ! Function declaration
  real(kind=8) :: square
  
  ! Main program variables
  real(kind=8) :: input_number, result
  
  ! Main program
  print *, 'Square Function Demo'
  print *, 'Enter a number:'
  read (*,*) input_number
  
  ! Call the function
  result = square(input_number)
  print *, 'Square of ', input_number, ' is ', result
  
end program function_demo

! Function definition
real(kind=8) function square(x)
  implicit none
  ! Function argument
  real(kind=8), intent(in) :: x
  
  ! Function body
  square = x * x
end function square
