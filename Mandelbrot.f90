program Mandelbrot
    use mandelbrot_types, only: dp
    use mandelbrot_constants, only: imaginary_unit
    use mandelbrot_utils, only: savetxt, linspace, meshgrid
    implicit none

    integer, parameter :: iterations = 100
    integer, parameter :: density = 1000
    real(dp) :: x_min, x_max, y_min, y_max
    real(dp) :: x(density, density), y(density, density)
    complex(dp) :: c(density, density), z(density, density)
    integer :: fractal(density, density)
    integer :: n

    x_min = -2.68_dp
    x_max =  1.32_dp
    y_min = -1.5_dp
    y_max =  1.5_dp

    call meshgrid(linspace(x_min, x_max, density), &
            linspace(y_min, y_max, density), x, y)

    c = x + imaginary_unit * y
    z = c
    fractal = 255

    do n = 1, iterations
        print "('Iteration ', i0)", n

        where (abs(z) <= 10.0_dp) z = z**2 + c
        where (fractal == 255 .and. abs(z) > 10.0_dp) fractal = 254 * (n - 1) / iterations
    end do

    print *, 'Saving...'

    ! log(0) üretmemek için 1 ekliyoruz (0 -> log(1) = 0)
    call savetxt('fractal.dat', log(1.0_dp + real(fractal, dp)))
    call savetxt('coord.dat', reshape([x_min, x_max, y_min, y_max], [4, 1]))
end program Mandelbrot
