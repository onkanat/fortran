program standard_deviation
  implicit none
  integer :: i, ncount = 0, errs = 0, opstat, rdstat
  real(kind=8) :: num, min_val, max_val, sum_val, average, stdsum, stddev
  real(kind=8), dimension(5000) :: numbers
  character(len=128) :: filename

  ! başlık
  write (*,*) "Standard Deviation Program Example."

  ! dosya adı al ve aç
  do
    write (*,'(a)', advance="no") "Enter File Name:"
    read (*,'(a)') filename
    open(unit=42, file=trim(filename), status="old", action="read", position="rewind", iostat=opstat)
    if (opstat == 0) exit

    write (*,'(a)') "Error, can not open file."
    write (*,'(a)') "Please re-enter."
    errs = errs + 1
    if (errs > 3) then
      write (*,'(a)') "Sorry you are having problems."
      write (*,'(a)') "Program terminated."
      stop
    end if
  end do

  ! sayıları oku
  do
    read (42, *, iostat=rdstat) num
    if (rdstat > 0) stop "Error on read."
    if (rdstat < 0) exit

    ncount = ncount + 1
    if (ncount > size(numbers)) stop "Array capacity exceeded."
    numbers(ncount) = num
  end do

  if (ncount == 0) stop "No data read."

  ! min, max, toplam
  min_val = numbers(1)
  max_val = numbers(1)
  sum_val = 0.0_8

  do i = 1, ncount
    if (numbers(i) < min_val) min_val = numbers(i)
    if (numbers(i) > max_val) max_val = numbers(i)
    sum_val = sum_val + numbers(i)
  end do

  average = sum_val / real(ncount, kind=8)

  ! standart sapma toplamı
  stdsum = 0.0_8
  do i = 1, ncount
    stdsum = stdsum + (average - numbers(i))**2
  end do

  if (ncount > 1) then
    stddev = sqrt( stdsum / real(ncount - 1, kind=8) )
  else
    stddev = 0.0_8
  end if

  ! sonuçları yazdır
  write (*,'(a)') "-------------------------------"
  write (*,'(a)') "Results:"

  do i = 1, ncount
    write (*,'(f10.4,2x)', advance="no") numbers(i)
    if (mod(i,10) == 0) write (*,*)
  end do
  if (mod(ncount,10) /= 0) write (*,*)

  write (*,'(a, f10.4)') "Minimum = ", min_val
  write (*,'(a, f10.4)') "Maximum = ", max_val
  write (*,'(a, f10.4)') "Sum = ", sum_val
  write (*,'(a, f10.4)') "Average = ", average
  write (*,'(a, f10.4)') "Standard Deviation = ", stddev

  close(42)
end program standard_deviation
