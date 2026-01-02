program case_converter
  implicit none
  integer :: i, str_len
  integer, parameter :: ascii_delta = iachar('a') - iachar('A')  ! 32
  character(len=80) :: input_line

  ! başlık
  write (*,'(a,/)') "Case Conversion Example"

  ! giriş istemi ve okuma
  write (*,'(a)', advance="no") "Enter String (80 char max): "
  read (*,'(a)') input_line

  ! sondaki boşlukları temizle ve uzunluğu al
  str_len = len_trim(input_line)

  ! küçük harfleri büyük harfe çevir
  do i = 1, str_len
    if (input_line(i:i) >= 'a' .and. input_line(i:i) <= 'z') then
      input_line(i:i) = achar(iachar(input_line(i:i)) - ascii_delta)
    end if
  end do

  ! sonuç
  write (*,'(/,a)') "-------------------------------------"
  write (*,'(a)') "Final String:"
  write (*,'(a,/)') input_line
end program case_converter
