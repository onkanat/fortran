# Square Function Example

This document explains how to write and structure functions in Fortran using a simple square function as an example.

## Function Structure

### Complete Function Example:
```fortran
real(kind=8) function square(x)
  implicit none
  real(kind=8), intent(in) :: x
  square = x * x
end function square
```

## Function Breakdown

### 1. Function Declaration
```fortran
real(kind=8) function square(x)
```
- `real(kind=8)`: Function returns double precision real number
- `function`: Indicates this is a function
- `square(x)`: Name of function and input parameter

### 2. Required Declarations
```fortran
implicit none
real(kind=8), intent(in) :: x
```
- `implicit none`: Mandatory declaration of all variables
- `real(kind=8)`: Double precision (64-bit) floating point
- `intent(in)`: Input-only parameter

### 3. Function Body
```fortran
square = x * x
```
- Direct assignment to function name (Fortran's return mechanism)

## Complete Working Program
```fortran
program square_demo
  implicit none
  real(kind=8) :: square
  real(kind=8) :: input_number, result
  
  print *, 'Square Function Demo'
  print *, 'Enter a number:'
  read (*,*) input_number
  
  result = square(input_number)
  print *, 'Square of ', input_number, ' is ', result
  
end program square_demo

real(kind=8) function square(x)
  implicit none
  real(kind=8), intent(in) :: x
  square = x * x
end function square
```

## Key Characteristics

1. **Single Return Value**: The function name itself is the return value
2. **Input Parameters**: Use `intent(in)` for read-only inputs
3. **Precision**: Use `real(kind=8)` for double precision calculations
4. **Required Elements**: 
   - `implicit none` declaration
   - Function header with return type
   - Function body with assignment to return variable

## Compilation and Execution
```bash
gfortran -o square_function square_function.f90
./square_function
```

## Why Functions Matter

Functions in Fortran improve code:
1. **Reusability**: Mathematical operations like square() can be used multiple times
2. **Modularity**: Separates calculations from main program logic
3. **Readability**: Makes code more understandable by breaking into logical units
4. **Maintainability**: If you need to change the algorithm, only change one function

This structure allows for clean, reusable code that follows Fortran's approach to function design.
