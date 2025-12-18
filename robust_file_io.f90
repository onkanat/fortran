program robust_file_io
  ! Güvenli dosya I/O örneği: tablo yazma, geri okuma ve basit istatistik.
  !
  ! Gösterilenler:
  ! - open(newunit=..., iostat=..., iomsg=...)
  ! - formatlı write
  ! - satır satır okuma ve iostat kontrolü
  implicit none

  character(len=*), parameter :: filename = 'numbers.txt'
  integer :: unit, ios
  character(len=200) :: iomsg
  integer :: i, n
  real(kind=8) :: x, sum_x

  n = 10

  ! 1) Dosyaya yaz
  open(newunit=unit, file=filename, status='replace', action='write', iostat=ios, iomsg=iomsg)
  if (ios /= 0) then
    print *, 'Hata: Dosya açılamadı (yazma). Detay: ', trim(iomsg)
    stop 1
  end if

  write(unit,'(a)') '# i  x'
  do i = 1, n
    x = real(i, kind=8) * 0.5_8
    write(unit,'(i4,1x,f10.4)') i, x
  end do
  close(unit)

  print *, 'Yazildi: ', filename

  ! 2) Dosyayı oku
  open(newunit=unit, file=filename, status='old', action='read', iostat=ios, iomsg=iomsg)
  if (ios /= 0) then
    print *, 'Hata: Dosya açılamadı (okuma). Detay: ', trim(iomsg)
    stop 1
  end if

  ! Başlık satırını atla
  read(unit,'(A)', iostat=ios, iomsg=iomsg)
  if (ios /= 0) then
    print *, 'Hata: Başlık okunamadı. Detay: ', trim(iomsg)
    close(unit)
    stop 1
  end if

  sum_x = 0.0_8
  i = 0
  do
    read(unit,*, iostat=ios) n, x
    if (ios /= 0) exit
    i = i + 1
    sum_x = sum_x + x
  end do
  close(unit)

  if (i == 0) then
    print *, 'Uyarı: Okunacak veri bulunamadı.'
  else
    print *, 'Okunan satir sayisi: ', i
    print *, 'Ortalama: ', sum_x / real(i, kind=8)
  end if

end program robust_file_io
