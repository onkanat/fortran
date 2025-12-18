program statistics_module_demo
  ! Modül kullanımı + generic interface demo.
  use, intrinsic :: iso_fortran_env, only: int32
  use statistics_utils, only: dp, mean, stddev
  implicit none

  real(dp) :: xr(5)
  integer(int32) :: xi(5)

  xr = [-2.0_dp, 0.5_dp, 1.0_dp, 3.5_dp, 10.0_dp]
  xi = [1_int32, 2_int32, 3_int32, 4_int32, 5_int32]

  print *, '=== statistics_utils Demo ==='
  print *, 'mean(xr)   = ', mean(xr)
  print *, 'stddev(xr) = ', stddev(xr)
  print *, 'mean(xi)   = ', mean(xi)
end program statistics_module_demo
