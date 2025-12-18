program iso_fortran_env_demo
  ! iso_fortran_env kullanımı: türler (kinds), standart birimler ve derleyici bilgisi.
  use, intrinsic :: iso_fortran_env, only: int32, int64, real32, real64, output_unit, error_unit
  implicit none

  integer(int32) :: i32
  integer(int64) :: i64
  real(real32) :: r32
  real(real64) :: r64

  i32 = 123_int32
  i64 = 1234567890123_int64
  r32 = 3.25_real32
  r64 = 3.141592653589793_real64

  write(output_unit, '(a)') '=== iso_fortran_env Demo ==='
  write(output_unit, '(a,i0)') 'int32 kind = ', int32
  write(output_unit, '(a,i0)') 'int64 kind = ', int64
  write(output_unit, '(a,i0)') 'real32 kind = ', real32
  write(output_unit, '(a,i0)') 'real64 kind = ', real64

  write(output_unit, '(a,i0)') 'i32 = ', i32
  write(output_unit, '(a,i0)') 'i64 = ', i64
  write(output_unit, '(a,f0.3)') 'r32 = ', r32
  write(output_unit, '(a,f0.15)') 'r64 = ', r64

  ! error_unit örneği (hata akışı):
  write(error_unit, '(a)') 'Not: Bu satır error_unit (stderr) üzerinden yazıldı.'
end program iso_fortran_env_demo
