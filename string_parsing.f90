program string_parsing
  ! Metin (character) işleme ve string içinden güvenli ayrıştırma örneği.
  !
  ! Gösterilenler:
  ! - character(len=:), allocatable (deferred length string)
  ! - trim/adjustl/index
  ! - internal read (string'den sayı okuma)
  implicit none

  character(len=:), allocatable :: line
  character(len=:), allocatable :: key
  character(len=:), allocatable :: value
  integer :: ios
  character(len=200) :: iomsg
  real(kind=8) :: radius

  print *, 'Bir anahtar=deger satiri girin (ornek: radius=2.5):'
  call read_line(line)

  call split_key_value(line, key, value, ios, iomsg)
  if (ios /= 0) then
    print *, 'Hata: Satir ayrıştırılamadı. Detay: ', trim(iomsg)
    stop 1
  end if

  print *, 'Anahtar: ', key
  print *, 'Deger  : ', value

  if (key == 'radius') then
    read(value, *, iostat=ios, iomsg=iomsg) radius
    if (ios /= 0) then
      print *, 'Hata: radius sayıya çevrilemedi. Detay: ', trim(iomsg)
      stop 1
    end if
    print *, 'Alan (pi*r^2) = ', 3.141592653589793_8 * radius * radius
  else
    print *, 'Not: Bu örnek sadece "radius" anahtarını sayıya çeviriyor.'
  end if

contains

  subroutine read_line(out_line)
    character(len=:), allocatable, intent(out) :: out_line
    character(len=1000) :: buffer
    integer :: ios_local

    read(*,'(A)', iostat=ios_local) buffer
    if (ios_local /= 0) then
      out_line = ''
    else
      out_line = trim(buffer)
    end if
  end subroutine read_line

  subroutine split_key_value(in_line, out_key, out_value, ios_out, iomsg_out)
    character(len=*), intent(in) :: in_line
    character(len=:), allocatable, intent(out) :: out_key
    character(len=:), allocatable, intent(out) :: out_value
    integer, intent(out) :: ios_out
    character(len=*), intent(out) :: iomsg_out

    integer :: pos
    character(len=:), allocatable :: temp

    ios_out = 0
    iomsg_out = ''

    temp = trim(adjustl(in_line))
    if (len_trim(temp) == 0) then
      ios_out = 1
      iomsg_out = 'Bos satir.'
      out_key = ''
      out_value = ''
      return
    end if

    pos = index(temp, '=')
    if (pos <= 1 .or. pos >= len_trim(temp)) then
      ios_out = 2
      iomsg_out = 'Format hatasi. "anahtar=deger" bekleniyor.'
      out_key = ''
      out_value = ''
      return
    end if

    out_key = trim(adjustl(temp(:pos-1)))
    out_value = trim(adjustl(temp(pos+1:)))

    if (len_trim(out_key) == 0 .or. len_trim(out_value) == 0) then
      ios_out = 3
      iomsg_out = 'Anahtar veya değer bos.'
      return
    end if
  end subroutine split_key_value

end program string_parsing
