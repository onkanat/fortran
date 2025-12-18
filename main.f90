program average
    ! Dinamik (allocatable) bir dizi okuyup ortalama hesabı yapan örnek.
    !
    ! Bu örnek şunları gösterir:
    ! - allocatable dizi ile dinamik bellek
    ! - sum/count intrinsics
    ! - maske (mask) kullanarak koşullu toplama
    implicit none

    real(kind=8), allocatable :: points(:)
    integer :: number_of_points
    integer :: ios
    character(len=200) :: iomsg
    real(kind=8) :: average_points
    real(kind=8) :: positive_average
    real(kind=8) :: negative_average

    average_points   = 0.0_8
    positive_average = 0.0_8
    negative_average = 0.0_8

    write (*,*) 'Ortalaması alınacak veri sayısını girin:'
    read  (*,*, iostat=ios, iomsg=iomsg) number_of_points
    if (ios /= 0) then
        write (*,*) 'Hata: Geçersiz giriş. Detay: ', trim(iomsg)
        stop 1
    end if
    if (number_of_points < 0) then
        write (*,*) 'Hata: Veri sayısı negatif olamaz.'
        stop 1
    end if
    if (number_of_points == 0) then
        write (*,*) 'Uyarı: Veri sayısı 0. Ortalamalar 0 olarak raporlanacak.'
    end if

    allocate (points(number_of_points), stat=ios, errmsg=iomsg)
    if (ios /= 0) then
        write (*,*) 'Hata: Bellek ayrılamadı. Detay: ', trim(iomsg)
        stop 1
    end if

    if (number_of_points > 0) then
        write (*,*) 'Ortalaması alınacak sayıları girin:'
        read  (*,*, iostat=ios, iomsg=iomsg) points
        if (ios /= 0) then
            write (*,*) 'Hata: Sayılar okunamadı. Detay: ', trim(iomsg)
            deallocate (points)
            stop 1
        end if

        ! Ortalama: sum(points) / N
        average_points = sum(points) / real(number_of_points, kind=8)

        ! Pozitif/negatif değerler için maske ile ortalama
        if (count(points > 0.0_8) > 0) then
            positive_average = sum(points, mask=points > 0.0_8) / real(count(points > 0.0_8), kind=8)
        end if
        if (count(points < 0.0_8) > 0) then
            negative_average = sum(points, mask=points < 0.0_8) / real(count(points < 0.0_8), kind=8)
        end if
    end if

    write (*,'(a,g12.4)') 'Ortalama = ', average_points
    write (*,'(a,g12.4)') 'Pozitiflerin ortalaması = ', positive_average
    write (*,'(a,g12.4)') 'Negatiflerin ortalaması = ', negative_average

    deallocate (points)
end program average

