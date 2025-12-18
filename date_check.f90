program date_check
  ! Modern Fortran örneği: Döngüler (conditionally controlled) + select case
  !
  ! Amaç:
  !   Kullanıcıdan (ay, gün, yıl) alıp tarihin geçerli olup olmadığını kontrol etmek.
  !   Hatalı girişlerde tekrar istemek.
  !
  ! Sınırlar (bu örnek için):
  !   yıl: 1970-2020
  !   ay : 1-12
  !   gün: aya ve (Şubat için) artık yıla göre
  !
  implicit none

  integer :: month, day, year, day_max
  integer :: io_stat
  character(len=200) :: io_msg

  write (*,*) 'Tarih Dogrulama Ornegi'
  write (*,*) 'Giris formati: ay gun yil  (orn: 12 31 2019)'

  do
     write (*,*)
     write (*,*) 'Ay, gun, yil girin:'
     read (*,*, iostat=io_stat, iomsg=io_msg) month, day, year

     if (io_stat /= 0) then
        write (*,*) 'Hata: Girdi okunamadi. Lutfen 3 adet tamsayi girin.'
        write (*,*) 'Detay: ', trim(io_msg)
        cycle
     end if

     if (month < 1 .or. month > 12) then
        write (*,*) 'Hata: Gecersiz ay (1-12).'
        cycle
     end if

     if (year < 1970 .or. year > 2020) then
        write (*,*) 'Hata: Gecersiz yil (1970-2020).'
        cycle
     end if

     select case (month)
     case (1, 3, 5, 7, 8, 10, 12)
        day_max = 31
     case (4, 6, 9, 11)
        day_max = 30
     case (2)
        if (mod(year, 4) == 0) then
           day_max = 29
        else
           day_max = 28
        end if
     end select

     if (day < 1 .or. day > day_max) then
        write (*,*) 'Hata: Gecersiz gun (1-', day_max, ').'
        cycle
     end if

     exit
  end do

  write (*,*)
  write (*,*) 'Gecerli tarih:', month, day, year

end program date_check
