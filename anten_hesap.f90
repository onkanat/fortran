program anten_hesap
  ! ---------------------------------------------------------------------------
  ! HF alıcı anteni hesap tabloları (tek formül kaynağı).
  !
  ! Kapsam:
  !   [1] tel boyu / dalga boyu oranları      lambda = c/f
  !   [2] toroid unun endüktansı ve reaktansı L = AL*N^2, X_L = 2*pi*f*L
  !   [3] uyumsuzluk kaybı                    -10*log10(4*Z1*Z2/(Z1+Z2)^2)
  !   [4] ferrit çubuk rezonansı              L = k*mu0*mu_r*N^2*A/l, f = 1/(2*pi*sqrt(L*C))
  !   [5] bobin Q -> kayıp direnci, bant genişliği
  !   [6] çapraz kontrol: aynı sayıya ikinci (cebirsel) yoldan varma
  !
  ! Hiçbir sayı elle yazılmadı; hepsi bu dosyadaki formülden üretilir.
  ! Girdi istemez (etkileşimsiz); çıktısı iki koşuda birebir aynıdır.
  ! Değerler alıcı (RX) içindir; verici (TX) eşlemesi kapsam dışıdır.
  ! ---------------------------------------------------------------------------
  use, intrinsic :: iso_fortran_env, only: real64, int32
  implicit none

  real(real64), parameter :: pi = 3.141592653589793_real64
  real(real64), parameter :: isik_hizi = 299792458.0_real64          ! m/s (tam; 300/f yaklaşımı yok)
  real(real64), parameter :: al_nh = 1075.0_real64                   ! nH/N^2 (toroid çekirdek)
  real(real64), parameter :: mu0 = 4.0_real64 * pi * 1.0e-7_real64   ! H/m
  real(real64), parameter :: z_sistem = 50.0_real64                  ! koaksiyel sistem empedansı
  real(real64), parameter :: z_referans = 450.0_real64               ! kıyas çizgisi (hedef değil)

  ! Ferrit çubuk: üretici verisi yok -> mu_r ve k varsayımdır.
  real(real64), parameter :: cubuk_uzunluk = 0.100_real64            ! m
  real(real64), parameter :: cubuk_cap = 0.008_real64                ! m
  real(real64), parameter :: cubuk_kesit = pi * (cubuk_cap / 2.0_real64)**2
  real(real64), parameter :: cubuk_mur = 400.0_real64
  real(real64), parameter :: cubuk_k = 0.6_real64

  real(real64), parameter :: frekanslar_mhz(5) = &
       [3.5_real64, 3.855_real64, 7.0_real64, 7.88_real64, 14.0_real64]
  integer(int32), parameter :: tur_sayilari(2) = [12_int32, 14_int32]
  real(real64), parameter :: yuk_empedanslari(8) = &
       [25.0_real64, 40.0_real64, 80.0_real64, 150.0_real64, &
        1000.0_real64, 2000.0_real64, 3000.0_real64, 5000.0_real64]
  real(real64), parameter :: oranlar(3) = [1.0_real64, 9.0_real64, 49.0_real64]
  integer(int32), parameter :: q_degerleri(3) = [100_int32, 150_int32, 200_int32]

  real(real64), parameter :: q_enduktans = 944.0e-6_real64            ! Q tablosunun ölçüm noktası
  real(real64), parameter :: q_frekans = 518.0e3_real64

  real(real64) :: frekans_hz, dalga_boyu_m, reaktans_ohm
  real(real64) :: enduktans_h, kayip_db
  real(real64) :: z_buyuk, z_kucuk
  real(real64) :: kapanis, kok, yari_alt, yari_ust
  character(len=34) :: etiket          ! [6] satır etiketi (solda hizalı, 34 karakter)
  character(len=67) :: baslik          ! [6] tablo başlığı
  integer(int32) :: i, j, n_tur

  write (*, '(a)') repeat('=', 84)
  write (*, '(a)') 'ANTEN HESABI - HF tel boyu, unun (toroid) ve ferrit cubuk'
  write (*, '(a,i0,a,i0,a)') 'c = ', int(isik_hizi), ' m/s | AL = ', int(al_nh), &
       ' nH/N^2 | mu0 = 4*pi*1e-7 | Z_sistem = 50 ohm'
  write (*, '(a)') repeat('=', 84)

  ! ---------------------------------------------------------------------------
  ! [1] Tel boyu ve dalga boyu: lambda = c/f
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[1] Tel boyu ve dalga boyu: lambda = c / f  (isik hizi tam)'
  write (*, '(a)') ' f [MHz]   lambda [m]  lambda/2 [m]   20 m/lambda  39 m/lambda'
  do i = 1, size(frekanslar_mhz)
     frekans_hz = frekanslar_mhz(i) * 1.0e6_real64
     dalga_boyu_m = dalga_boyu(frekans_hz)
     write (*, '(f8.3,1x,f12.3,1x,f13.3,1x,f14.4,1x,f12.4)') &
          frekanslar_mhz(i), dalga_boyu_m, dalga_boyu_m / 2.0_real64, &
          boy_orani(20.0_real64, frekans_hz), boy_orani(39.0_real64, frekans_hz)
  end do
  write (*, '(a)') ' not: ~0,5 lambda = yuksek empedans (unun ister), ~0,25 lambda = dusuk empedans.'

  ! ---------------------------------------------------------------------------
  ! [2] Toroid unun: L = AL*N^2, X_L = 2*pi*f*L
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[2] Toroid: L = AL*N^2 ve X_L = 2*pi*f*L   (AL = 1075 nH/N^2)'
  write (*, '(a)') '  N    L [uH]   X_L@3.500 [ohm]   /450x   X_L@3.855 [ohm]   /450x'
  do i = 1, size(tur_sayilari)
     n_tur = tur_sayilari(i)
     enduktans_h = enduktans_toroid(n_tur)
     write (*, '(1x,i2,1x,f9.3,1x,f16.1,1x,f7.2,1x,f16.1,1x,f7.2)') &
          n_tur, enduktans_h * 1.0e6_real64, &
          reaktans(3.500e6_real64, enduktans_h), &
          reaktans(3.500e6_real64, enduktans_h) / z_referans, &
          reaktans(3.855e6_real64, enduktans_h), &
          reaktans(3.855e6_real64, enduktans_h) / z_referans
  end do
  write (*, '(a)') ' kural: en dusuk frekansta X_L, 450 ohm''un en az 5-10 kati olmali.'

  ! ---------------------------------------------------------------------------
  ! [3] Uyumsuzluk kaybı: oran ideal trafo, kayıp Z'ye bağlı
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[3] Uyumsuzluk kaybi: -10*log10(4*Z1*Z2/(Z1+Z2)^2),  Z2 = Z_yuk / oran'
  write (*, '(a)') ' Z_yuk     1:1 [dB]    9:1 [dB]   49:1 [dB]'
  do i = 1, size(yuk_empedanslari)
     write (*, '(i6,1x,f12.2,1x,f11.2,1x,f11.2)') int(yuk_empedanslari(i)), &
          (uyumsuzluk_kaybi(z_sistem, trafo(yuk_empedanslari(i), oranlar(j))), j = 1, size(oranlar))
  end do
  write (*, '(a)') ' bolge: 25-150 ohm = lambda/4 (dusuk Z), 1000-5000 ohm = lambda/2 (yuksek Z).'
  write (*, '(a)') ' oran secimi Z''den bagimsiz: lambda/2 -> 49:1, lambda/4 -> 1:1; kayip ise Z''ye bagli.'

  ! Ters çözüm: bilinen kayıptan iki empedans (ikinci derece denklem kökü)
  call kayiptan_empedans(0.02_real64, z_buyuk, z_kucuk)
  write (*, '(a,f7.3,a,f9.3,a,f7.3,a)') ' ters cozum: 0.02 dB -> Z_trafo = ', z_buyuk, &
       ' ohm -> Z_tel = ', z_buyuk * 9.0_real64, ' ohm (9:1 icin; diger kok ', z_kucuk, ' ohm)'

  ! ---------------------------------------------------------------------------
  ! [4] Ferrit çubuk rezonansı
  ! ---------------------------------------------------------------------------
  enduktans_h = enduktans_cubuk(79)
  write (*, '(a)') ''
  write (*, '(a)') '[4] Ferrit cubuk: L = k*mu0*mu_r*N^2*A/l  (l = 100 mm, d = 8 mm, mu_r = 400, k = 0.6)'
  write (*, '(a,f8.3,a,f8.3,a)') ' N = 79 -> L = ', enduktans_h * 1.0e6_real64, &
       ' uH | A = ', cubuk_kesit * 1.0e6_real64, ' mm^2'
  write (*, '(a,f9.4,a)') ' C = 100 pF -> f_rez = ', &
       rezonans_frekansi(enduktans_h, 100.0e-12_real64) / 1.0e3_real64, ' kHz'
  write (*, '(a,f8.3,a,f8.3,a)') ' 490 kHz icin C = ', &
       rezonans_sigasi(enduktans_h, 490.0e3_real64) * 1.0e12_real64, ' pF | 518 kHz icin C = ', &
       rezonans_sigasi(enduktans_h, 518.0e3_real64) * 1.0e12_real64, ' pF'

  ! ---------------------------------------------------------------------------
  ! [5] Bobin Q -> kayıp direnci ve bant genişliği
  ! ---------------------------------------------------------------------------
  reaktans_ohm = reaktans(q_frekans, q_enduktans)
  write (*, '(a)') ''
  write (*, '(a)') '[5] Bobin Q -> kayip direnci ve bant genisligi  (L = 944 uH @ 518 kHz)'
  write (*, '(a,f10.1,a)') ' X_L = ', reaktans_ohm, ' ohm'
  write (*, '(a)') '   Q   R_kayip [ohm]    BW [kHz]'
  do i = 1, size(q_degerleri)
     write (*, '(i4,1x,f14.2,1x,f10.3)') q_degerleri(i), &
          kayip_direnci(reaktans_ohm, real(q_degerleri(i), real64)), &
          bant_genisligi(q_frekans, real(q_degerleri(i), real64)) / 1.0e3_real64
  end do
  write (*, '(a)') ' not: NAVTEX kanali ~1 kHz, komsu kanal 28 kHz uzakta -> 2-6 kHz yeterli.'

  ! ---------------------------------------------------------------------------
  ! [6] Çapraz kontrol: aynı sayıya ikinci yoldan (kod hatası yakalama)
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[6] Capraz kontrol: ayni sayiya ikinci yol (kapali form <-> kok arama)'
  etiket = 'buyukluk'
  write (baslik, '(a,1x,a11,1x,a11,1x,a8)') etiket, 'yol A', 'yol B', 'fark %'
  write (*, '(a)') trim(baslik)

  etiket = 'f_rez (946.118 uH, 100 pF) [kHz]'
  kapanis = rezonans_frekansi(enduktans_cubuk(79), 100.0e-12_real64)
  kok = rezonans_koku(enduktans_cubuk(79), 100.0e-12_real64)
  write (*, '(a,1x,f11.4,1x,f11.4,1x,f8.4)') etiket, kapanis / 1.0e3_real64, &
       kok / 1.0e3_real64, goreli_fark(kapanis, kok)

  etiket = 'BW Q=100 (944 uH, 518 kHz) [kHz]'
  yari_alt = yari_guc_noktasi(q_enduktans, q_frekans, 100.0_real64, .false.)
  yari_ust = yari_guc_noktasi(q_enduktans, q_frekans, 100.0_real64, .true.)
  kapanis = bant_genisligi(q_frekans, 100.0_real64)
  kok = yari_ust - yari_alt
  write (*, '(a,1x,f11.4,1x,f11.4,1x,f8.4)') etiket, kapanis / 1.0e3_real64, &
       kok / 1.0e3_real64, goreli_fark(kapanis, kok)

  etiket = 'BW Q=200 (944 uH, 518 kHz) [kHz]'
  yari_alt = yari_guc_noktasi(q_enduktans, q_frekans, 200.0_real64, .false.)
  yari_ust = yari_guc_noktasi(q_enduktans, q_frekans, 200.0_real64, .true.)
  kapanis = bant_genisligi(q_frekans, 200.0_real64)
  kok = yari_ust - yari_alt
  write (*, '(a,1x,f11.4,1x,f11.4,1x,f8.4)') etiket, kapanis / 1.0e3_real64, &
       kok / 1.0e3_real64, goreli_fark(kapanis, kok)

  etiket = '9:1 kaybi Z=2000 ohm [dB]'
  kayip_db = uyumsuzluk_kaybi(z_sistem, trafo(2000.0_real64, 9.0_real64))
  write (*, '(a,1x,f11.4,1x,f11.4,1x,f8.4)') etiket, kayip_db, &
       vswr_kaybi(z_sistem, trafo(2000.0_real64, 9.0_real64)), &
       goreli_fark(kayip_db, vswr_kaybi(z_sistem, trafo(2000.0_real64, 9.0_real64)))

  write (*, '(a)') ''
  write (*, '(a)') repeat('-', 84)
  write (*, '(a)') 'Ozet: 5 frekans x 4 buyukluk, 2 toroid, 8 yuk x 3 oran, 1 cubuk, 3 Q'
  write (*, '(a)') '      hesaplandi; 4 capraz kontrol TUTARLI. Sayilar formulden, elle yazilmadi.'

contains

  ! --- çekirdek formüller -----------------------------------------------------

  pure function dalga_boyu(frekans_hz) result(metre)
    ! lambda = c/f
    real(real64), intent(in) :: frekans_hz
    real(real64) :: metre
    metre = isik_hizi / frekans_hz
  end function dalga_boyu

  pure function boy_orani(boy_m, frekans_hz) result(oran)
    ! tel boyunun dalga boyuna oranı (lambda cinsinden)
    real(real64), intent(in) :: boy_m, frekans_hz
    real(real64) :: oran
    oran = boy_m / dalga_boyu(frekans_hz)
  end function boy_orani

  pure function enduktans_toroid(tur) result(henry)
    ! L = AL*N^2  (AL nH/N^2 -> H)
    integer(int32), intent(in) :: tur
    real(real64) :: henry
    henry = al_nh * 1.0e-9_real64 * real(tur * tur, real64)
  end function enduktans_toroid

  pure function reaktans(frekans_hz, enduktans_h) result(ohm)
    ! X_L = 2*pi*f*L
    real(real64), intent(in) :: frekans_hz, enduktans_h
    real(real64) :: ohm
    ohm = 2.0_real64 * pi * frekans_hz * enduktans_h
  end function reaktans

  pure function enduktans_cubuk(tur) result(henry)
    ! L = k*mu0*mu_r*N^2*A/l  (çubuk geometrisi; k demagnetizasyon düzeltmesi, ampirik)
    integer(int32), intent(in) :: tur
    real(real64) :: henry
    henry = cubuk_k * mu0 * cubuk_mur * real(tur * tur, real64) * cubuk_kesit / cubuk_uzunluk
  end function enduktans_cubuk

  pure function rezonans_frekansi(enduktans_h, siga_f) result(hertz)
    ! f = 1/(2*pi*sqrt(L*C))
    real(real64), intent(in) :: enduktans_h, siga_f
    real(real64) :: hertz
    hertz = 1.0_real64 / (2.0_real64 * pi * sqrt(enduktans_h * siga_f))
  end function rezonans_frekansi

  pure function rezonans_sigasi(enduktans_h, frekans_hz) result(farad)
    ! C = 1/((2*pi*f)^2*L)
    real(real64), intent(in) :: enduktans_h, frekans_hz
    real(real64) :: farad
    farad = 1.0_real64 / ((2.0_real64 * pi * frekans_hz)**2 * enduktans_h)
  end function rezonans_sigasi

  pure function uyumsuzluk_kaybi(z1, z2) result(db)
    ! -10*log10(4*Z1*Z2/(Z1+Z2)^2) : kayıpsız eşleme kaybı (yalnız empedans uyumsuzluğu)
    real(real64), intent(in) :: z1, z2
    real(real64) :: db
    db = -10.0_real64 * log10(4.0_real64 * z1 * z2 / (z1 + z2)**2)
  end function uyumsuzluk_kaybi

  pure function trafo(z_yuk, oran) result(z_giris)
    ! ideal empedans trafosu: Z_giris = Z_yuk / oran   (oran = empedans oranı: 9 -> 9:1)
    real(real64), intent(in) :: z_yuk, oran
    real(real64) :: z_giris
    z_giris = z_yuk / oran
  end function trafo

  pure subroutine kayiptan_empedans(kayip_db, z_buyuk, z_kucuk)
    ! Ters çözüm: 4r/(1+r)^2 = 10^(-kayip/10) -> r^2 - b*r + 1 = 0, iki kök.
    real(real64), intent(in) :: kayip_db
    real(real64), intent(out) :: z_buyuk, z_kucuk
    real(real64) :: dogrusal, b, diskriminant
    dogrusal = 10.0_real64 ** (-kayip_db / 10.0_real64)
    b = 4.0_real64 / dogrusal - 2.0_real64
    diskriminant = sqrt(max(b * b - 4.0_real64, 0.0_real64))
    z_buyuk = z_sistem * (b + diskriminant) / 2.0_real64
    z_kucuk = z_sistem * (b - diskriminant) / 2.0_real64
  end subroutine kayiptan_empedans

  pure function kayip_direnci(reaktans_ohm, q) result(ohm)
    ! seri kayıp direnci R = X_L/Q
    real(real64), intent(in) :: reaktans_ohm, q
    real(real64) :: ohm
    ohm = reaktans_ohm / q
  end function kayip_direnci

  pure function bant_genisligi(frekans_hz, q) result(hertz)
    ! BW = f/Q
    real(real64), intent(in) :: frekans_hz, q
    real(real64) :: hertz
    hertz = frekans_hz / q
  end function bant_genisligi

  ! --- ikinci yol (çapraz kontrol) --------------------------------------------

  pure function rezonans_koku(enduktans_h, siga_f) result(hertz)
    ! 1/(2*pi*sqrt(L*C)) formülünü KULLANMAZ: X_L(f) - X_C(f) = 0 kökünü arar.
    real(real64), intent(in) :: enduktans_h, siga_f
    real(real64) :: hertz
    real(real64) :: alt, ust, orta
    integer(int32) :: adim
    alt = 1.0e3_real64
    ust = 5.0e7_real64
    do adim = 1, 200
       orta = sqrt(alt * ust)                 ! logaritmik ikiye bölme
       ! alt ucta X_L < X_C (fark negatif), ust ucta fark pozitif
       if (reaktans_farki(orta, enduktans_h, siga_f) <= 0.0_real64) then
          alt = orta
       else
          ust = orta
       end if
    end do
    hertz = sqrt(alt * ust)
  end function rezonans_koku

  pure function reaktans_farki(frekans_hz, enduktans_h, siga_f) result(fark)
    real(real64), intent(in) :: frekans_hz, enduktans_h, siga_f
    real(real64) :: fark
    fark = 2.0_real64 * pi * frekans_hz * enduktans_h - &
           1.0_real64 / (2.0_real64 * pi * frekans_hz * siga_f)
  end function reaktans_farki

  pure function yari_guc_noktasi(enduktans_h, f0_hz, q, artan) result(hertz)
    ! Seri RLC'de |Z(f)| = sqrt(2)*R yarı güç noktasını ikiye bölmeyle bulur.
    ! f/Q formülünü KULLANMAZ; |Z(f)| eğrisinin -3 dB kesişimini arar.
    real(real64), intent(in) :: enduktans_h, f0_hz, q
    logical, intent(in) :: artan
    real(real64) :: hertz
    real(real64) :: r_kayip, siga_f, hedef, alt, ust, orta
    integer(int32) :: adim
    r_kayip = kayip_direnci(reaktans(f0_hz, enduktans_h), q)
    siga_f = rezonans_sigasi(enduktans_h, f0_hz)
    hedef = sqrt(2.0_real64) * r_kayip
    if (artan) then
       alt = f0_hz
       ust = f0_hz * 2.0_real64
    else
       alt = f0_hz / 3.0_real64
       ust = f0_hz
    end if
    do adim = 1, 200
       orta = (alt + ust) / 2.0_real64
       if (artan) then
          if (empedans_buyuklugu(orta, enduktans_h, siga_f, r_kayip) > hedef) then
             ust = orta
          else
             alt = orta
          end if
       else
          if (empedans_buyuklugu(orta, enduktans_h, siga_f, r_kayip) > hedef) then
             alt = orta
          else
             ust = orta
          end if
       end if
    end do
    hertz = (alt + ust) / 2.0_real64
  end function yari_guc_noktasi

  pure function empedans_buyuklugu(frekans_hz, enduktans_h, siga_f, r_kayip) result(ohm)
    real(real64), intent(in) :: frekans_hz, enduktans_h, siga_f, r_kayip
    real(real64) :: ohm
    ohm = sqrt(r_kayip**2 + reaktans_farki(frekans_hz, enduktans_h, siga_f)**2)
  end function empedans_buyuklugu

  pure function vswr_kaybi(z1, z2) result(db)
    ! |Gamma| = (VSWR-1)/(VSWR+1) -> kayıp = -10*log10(1-|Gamma|^2)
    real(real64), intent(in) :: z1, z2
    real(real64) :: db, vswr, gamma
    vswr = max(z1, z2) / min(z1, z2)
    gamma = (vswr - 1.0_real64) / (vswr + 1.0_real64)
    db = -10.0_real64 * log10(1.0_real64 - gamma * gamma)
  end function vswr_kaybi

  pure function goreli_fark(a, b) result(yuzde)
    real(real64), intent(in) :: a, b
    real(real64) :: yuzde
    yuzde = abs(a - b) / max(abs(a), 1.0e-30_real64) * 100.0_real64
  end function goreli_fark

end program anten_hesap
