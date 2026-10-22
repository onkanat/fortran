program gezer_kren_hesabi
  ! ---------------------------------------------------------------------------
  ! Gezer köprülü kren (overhead travelling crane) konstrüksiyon ve hesabı.
  !
  ! Örnek veriler (kaynak metin: "Gezer Kren Köprüsü Konstrüksiyonu ve Hesabı", EK-A2):
  !   Q_K = 10 000 kg kaldırma yükü · G_A = 2 800 kg araba · L_K = 20 m köprü açıklığı
  !   esas kiriş 400 kg/m -> G_K = 2*400*20 = 16 000 kg · H2 yük sınıfı, orta işletme
  !
  ! Bölümler:
  !   [1] araba tekerlek çapı         [2] hızlar
  !   [3] köprü tekerlek çapı         [4] araba yürütme motoru
  !   [5] köprü yürütme motoru        [6] sehim ve kiriş kesiti
  !   [7] eğilme momentleri           [8] eğilme gerilmesi
  !   [9] baş kiriş                   [10] çapraz kontrol
  !   [11] M(x) / V(x) tablosu (Şekil 5'in sayısal karşılığı)
  !
  ! Birimler belgedeki gibi: kuvvet daN, uzunluk cm (L_K hariç m), gerilme daN/cm².
  ! kg -> daN dönüşümü belgedeki gibi 1:1 alınır (1 kg yük ~ 1 daN).
  ! Girdi istemez; iki koşuda çıktı birebir aynıdır.
  ! ---------------------------------------------------------------------------
  use, intrinsic :: iso_fortran_env, only: real64, int32
  implicit none

  real(real64), parameter :: pi = 3.141592653589793_real64
  real(real64), parameter :: yer_cekimi = 9.81_real64              ! m/s^2
  real(real64), parameter :: elastisite = 2.1e6_real64             ! daN/cm^2 (çelik)

  ! --- örnek veriler ---------------------------------------------------------
  real(real64), parameter :: q_kaldirma = 10000.0_real64            ! daN
  real(real64), parameter :: g_araba = 2800.0_real64                ! daN
  real(real64), parameter :: l_kopru_m = 20.0_real64                ! m
  real(real64), parameter :: kiris_birim_agirlik = 400.0_real64     ! kg/m (bir esas kiriş)
  real(real64), parameter :: g_kopru = 2.0_real64 * kiris_birim_agirlik * l_kopru_m   ! daN
  real(real64), parameter :: l_araba_min = 1.0_real64               ! m (arabanın baş kirişe en yakın konumu)

  ! --- tekerlek / ray / malzeme katsayıları ----------------------------------
  real(real64), parameter :: c1_araba = 0.63_real64                 ! araba tekerleği (belge §2.1)
  real(real64), parameter :: c1_araba_alt = 0.50_real64             ! belgedeki ikinci satır (çelişki)
  real(real64), parameter :: c1_kopru = 0.80_real64                 ! köprü tekerleği (GS-52 / St 50)
  real(real64), parameter :: c2 = 1.03_real64                       ! devir katsayısı (n = 25 d/d)
  real(real64), parameter :: c3 = 1.00_real64                       ! çalışma süresi katsayısı (%30)
  real(real64), parameter :: ray_kafa_yassi = 4.0_real64            ! cm (yassı ray 50x40, k-2r)
  real(real64), parameter :: ray_kafa_a55 = 5.5_real64              ! cm (A55 rayı)
  real(real64), parameter :: ray_kose_r = 0.5_real64                ! cm

  ! --- yürütme mekanizması ---------------------------------------------------
  real(real64), parameter :: yatak_surtunme = 0.08_real64           ! kaymalı yatak
  real(real64), parameter :: surtunme_kolu = 0.05_real64            ! cm
  real(real64), parameter :: emniyet_araba = 1.2_real64
  real(real64), parameter :: emniyet_kopru = 1.2_real64
  real(real64), parameter :: ivme_araba = 0.25_real64               ! m/s^2
  real(real64), parameter :: ivme_kopru = 0.40_real64               ! m/s^2
  real(real64), parameter :: verim = 0.85_real64
  real(real64), parameter :: d_aks_araba = 5.0_real64               ! cm (50 mm)
  real(real64), parameter :: d_aks_kopru = 9.0_real64               ! cm (90 mm)
  real(real64), parameter :: tekerlek_devir = 25.0_real64           ! d/d

  ! --- kiriş kesiti (Şekil 4) ------------------------------------------------
  real(real64), parameter :: kesit_b = 50.0_real64                  ! cm (B)
  real(real64), parameter :: kesit_h = 100.0_real64                 ! cm (H)
  real(real64), parameter :: baslik_kalinlik = 1.2_real64           ! cm (s)
  real(real64), parameter :: govde_kalinlik = 0.8_real64            ! cm (s0)
  real(real64), parameter :: kesit_h_ic = kesit_h - 2.0_real64 * baslik_kalinlik  ! h = 97,6 cm

  ! --- yük katsayıları ve emniyet gerilmesi ----------------------------------
  real(real64), parameter :: phi_zati = 1.1_real64                  ! zati ağırlık katsayısı (yürüme hızı)
  real(real64), parameter :: psi_yuk = 1.3_real64                    ! yük kaldırma katsayısı (H2)
  real(real64), parameter :: sigma_em = 1600.0_real64               ! daN/cm^2 (St 37, DIN 15018)
  real(real64), parameter :: sigma_em_st52 = 2400.0_real64          ! daN/cm^2 (St 52-3)

  ! --- baş kiriş -------------------------------------------------------------
  real(real64), parameter :: bas_teker_arasi = 2.6_real64           ! m (L_R)
  real(real64), parameter :: bas_kiris_arasi = 1.6_real64           ! m (L_E)

  real(real64) :: l_kopru, r_araba, p_em_araba, d_araba, d_araba_alt
  real(real64) :: r_kopru, p_em_kopru, d_kopru, r0_kopru
  real(real64) :: v_araba, v_kopru, v_araba_ms, v_kopru_ms
  real(real64) :: w_yur_araba, w_iv_araba, n_yur_araba, n_iv_araba, n_n_araba
  real(real64) :: q_toplam, w_yur_kopru, w_iv_kopru, n_yur_kopru, n_iv_kopru, n_n_kopru
  real(real64) :: f_em, iz_gerekli, iz_kesit, f_top, f_sayisal, w_z, w_y
  real(real64) :: m_i, m_ii, m_t, m_k, ivme, m_at_m, m_at
  real(real64) :: sigma, kullanim
  real(real64) :: f_bas, l_b, m_bas, w_bas, w_bas_toplam
  real(real64) :: sigma_terimli
  real(real64) :: x, m_x, v_x, m_maks
  character(len=38) :: etiket
  character(len=59) :: baslik
  integer(int32) :: i

  l_kopru = l_kopru_m * 100.0_real64        ! cm

  write (*, '(a)') repeat('=', 88)
  write (*, '(a)') 'GEZER KOPRULU KREN - KONSTRUKSIYON VE HESAP'
  write (*, '(a)') 'Q_K = 10000 daN | G_A = 2800 daN | L_K = 20 m | G_K = 16000 daN | sinif H2'
  write (*, '(a)') 'g = 9.81 m/s^2 | E = 2.1e6 daN/cm^2 | sigma_em = 1600 daN/cm^2 (St 37) | phi = 1.1 | psi = 1.3'
  write (*, '(a)') repeat('=', 88)

  ! ---------------------------------------------------------------------------
  ! [1] Araba tekerlek çapı — DIN 15070
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[1] Araba tekerlek capi (DIN 15070):  D = R / (p_em * C2 * C3 * b)'
  r_araba = (q_kaldirma + g_araba) / 4.0_real64
  p_em_araba = basinc_emniyeti(c1_araba)
  d_araba = tekerlek_capi(r_araba, p_em_araba, c2, c3, ray_kafa_yassi)
  p_em_araba = basinc_emniyeti(c1_araba_alt)
  d_araba_alt = tekerlek_capi(r_araba, p_em_araba, c2, c3, ray_kafa_yassi)
  call satir(' R_A = (Q_K + G_A)/4', r_araba, 'daN')
  call satir(' p_em = 56 * C1   (C1 = 0,63)', basinc_emniyeti(c1_araba), 'daN/cm2')
  call satir(' D_A', d_araba, 'cm')
  call satir(' D_A   (C1 = 0,50 satiri)', d_araba_alt, 'cm')
  write (*, '(a)') ' secim: standart cap 250 mm (belge 222 mm yaziyor; formul 220 mm veriyor)'
  write (*, '(a)') ' not: belgedeki C1 = 0,50 satiri kullanilirsa 315 mm gerekir -> 250 mm ile celisir.'

  ! ---------------------------------------------------------------------------
  ! [2] Hızlar
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[2] Hizlar:  V = D * pi * n'
  d_araba = 25.0_real64                    ! seçilen standart çap (cm)
  v_araba = d_araba * pi * tekerlek_devir / 100.0_real64     ! m/min (teorik)
  d_kopru = 50.0_real64
  v_kopru = d_kopru * pi * tekerlek_devir / 100.0_real64
  v_araba_ms = 20.0_real64 / 60.0_real64   ! anma hızı (belge: 20 m/dak)
  v_kopru_ms = 40.0_real64 / 60.0_real64   ! anma hızı (belge: 40 m/dak)
  call satir(' V_araba (teorik, D*pi*n)', v_araba, 'm/min')
  call satir(' V_kopru (teorik, D*pi*n)', v_kopru, 'm/min')
  call satir(' V_araba (anma, guc hesabi)', v_araba_ms * 60.0_real64, 'm/min')
  call satir(' V_kopru (anma, guc hesabi)', v_kopru_ms * 60.0_real64, 'm/min')

  ! ---------------------------------------------------------------------------
  ! [3] Köprü tekerlek çapı — iki yol
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[3] Kopru tekerlek capi: maksimum kuvvet (araba bas kirise yanasik)'
  r_kopru = 0.5_real64 * ((q_kaldirma + g_araba) * (l_kopru_m - l_araba_min) / l_kopru_m + g_kopru / 2.0_real64)
  p_em_kopru = basinc_emniyeti(c1_kopru)
  d_kopru = tekerlek_capi(r_kopru, p_em_kopru, c2, c3, ray_kafa_a55 - 2.0_real64 * ray_kose_r)
  r0_kopru = r_kopru / (c1_kopru * c2 * c3)
  call satir(' R_kopru', r_kopru, 'daN')
  call satir(' p_em = 56 * C1   (C1 = 0,80)', p_em_kopru, 'daN/cm2')
  call satir(' D_kopru  (gerilme yolu)', d_kopru, 'cm')
  call satir(' R0 = R / (C1*C2*C3)  (tablo yolu)', r0_kopru, 'daN')
  write (*, '(a)') ' secim: standart cap 500 mm (her iki yol da 500 mm veriyor)'
  d_kopru = 50.0_real64                                       ! seçilen standart çap (cm)

  ! ---------------------------------------------------------------------------
  ! [4] Araba yürütme motoru
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[4] Araba yurutme motoru:  W = n * (Q+G)/D * (mu*d + 2f),  N = W*V/(102*eta)'
  w_yur_araba = yurume_direnci(q_kaldirma + g_araba, d_araba, yatak_surtunme, d_aks_araba, &
                               surtunme_kolu, emniyet_araba)
  w_iv_araba = ivme_direnci(q_kaldirma + g_araba, yer_cekimi, ivme_araba, emniyet_araba)
  n_yur_araba = guc(w_yur_araba, v_araba_ms, verim)
  n_iv_araba = guc(w_iv_araba, v_araba_ms, verim)
  n_n_araba = (n_yur_araba + n_iv_araba) / 1.7_real64
  call satir(' W_yurume', w_yur_araba, 'daN')
  call satir(' N_yurume', n_yur_araba, 'kW')
  call satir(' W_ivme', w_iv_araba, 'daN')
  call satir(' N_ivme', n_iv_araba, 'kW')
  call satir(' N_anma = (N_yur+N_iv)/1,7', n_n_araba, 'kW')

  ! ---------------------------------------------------------------------------
  ! [5] Köprü yürütme motoru
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[5] Kopru yurutme motoru (4 tekerlek uzerindeki toplam yuk)'
  q_toplam = q_kaldirma + g_araba + g_kopru
  w_yur_kopru = yurume_direnci(q_toplam, d_kopru, yatak_surtunme, d_aks_kopru, &
                               surtunme_kolu, emniyet_kopru)
  w_iv_kopru = ivme_direnci(q_toplam, yer_cekimi, ivme_kopru, emniyet_kopru)
  n_yur_kopru = guc(w_yur_kopru, v_kopru_ms, verim)
  n_iv_kopru = guc(w_iv_kopru, v_kopru_ms, verim)
  n_n_kopru = (n_yur_kopru + n_iv_kopru) / 1.8_real64
  call satir(' Q_toplam', q_toplam, 'daN')
  call satir(' W_yurume', w_yur_kopru, 'daN')
  call satir(' N_yurume', n_yur_kopru, 'kW')
  call satir(' W_ivme', w_iv_kopru, 'daN')
  call satir(' N_ivme', n_iv_kopru, 'kW')
  call satir(' N_anma = (N_yur+N_iv)/1,8', n_n_kopru, 'kW')
  write (*, '(a)') ' secim: ayni hizada 2 x 5,5 kW (uzun acikliklarda senkron iki motor)'

  ! ---------------------------------------------------------------------------
  ! [6] Sehim ve kiriş kesiti
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[6] Sehim: f_top = L^3/(48 E Iz) * [5/8 GK + (QK+GA)]/2  <=  f_em = L/750'
  f_em = l_kopru / 750.0_real64
  iz_gerekli = gerekli_ataket_momenti(l_kopru, elastisite, f_em, g_kopru, q_kaldirma, g_araba, 2)
  iz_kesit = kesit_ataket_momenti(kesit_b, kesit_h, kesit_h_ic, govde_kalinlik)
  f_top = sehim_toplam(l_kopru, elastisite, iz_kesit, g_kopru, q_kaldirma, g_araba, 2)
  w_z = iz_kesit / (kesit_h / 2.0_real64)
  w_y = 2.0_real64 * baslik_kalinlik * kesit_b**2 / 6.0_real64
  call satir(' f_em = L/750', f_em, 'cm')
  call satir(' Iz gerekli (tek kiris)', iz_gerekli, 'cm4')
  call satir(' Iz kesit (Sekil 4)', iz_kesit, 'cm4')
  call satir(' f_top (secen kesit)', f_top, 'cm')
  call satir(' W_z = Iz/(H/2)', w_z, 'cm3')
  call satir(' W_y = 2*s*B^2/6', w_y, 'cm3')
  if (iz_kesit >= iz_gerekli) then
     write (*, '(a)') ' karar: kesit YETERLI (Iz_kesit > Iz_gerekli)'
  else
     write (*, '(a)') ' karar: kesit YETERSIZ'
  end if

  ! ---------------------------------------------------------------------------
  ! [7] Eğilme momentleri
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[7] Egilme momentleri (bir esas kiris icin)'
  m_i = g_kopru * l_kopru / 8.0_real64
  m_ii = g_araba * l_kopru / 4.0_real64
  m_t = 0.5_real64 * (m_i + m_ii)
  m_k = 0.5_real64 * q_kaldirma * l_kopru / 4.0_real64
  ivme = v_kopru_ms / 4.0_real64                              ! V/t_f, t_f = 4 s
  m_at_m = ivme * l_kopru_m / (16.0_real64 * yer_cekimi) * &
           (2.0_real64 * (q_kaldirma + g_araba) + g_kopru)     ! daN*m
  m_at = m_at_m * 100.0_real64                                 ! daN*cm
  call satir(' M_I  = GK*L/8', m_i, 'daN*cm')
  call satir(' M_II = GA*L/4', m_ii, 'daN*cm')
  call satir(' M_T  = (M_I + M_II)/2', m_t, 'daN*cm')
  call satir(' M_K  = QK*L/(4*2)', m_k, 'daN*cm')
  call satir(' a = V_kopru/t_f  (t_f = 4 s)', ivme, 'm/s2')
  call satir(' M_AT', m_at, 'daN*cm')

  ! ---------------------------------------------------------------------------
  ! [8] Eğilme gerilmesi
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[8] Egilme gerilmesi:  sigma = (phi*M_T + psi*M_K)/W_z + M_AT/W_y'
  sigma = (phi_zati * m_t + psi_yuk * m_k) / w_z + m_at / w_y
  kullanim = sigma / sigma_em * 100.0_real64
  call satir(' sigma', sigma, 'daN/cm2')
  call satir(' sigma', sigma / 10.0_real64, 'N/mm2')
  call satir(' sigma_em (St 37)', sigma_em, 'daN/cm2')
  call satir(' kullanim orani (St 37)', kullanim, '%')
  call satir(' kullanim orani (St 52-3)', sigma / sigma_em_st52 * 100.0_real64, '%')
  if (sigma <= sigma_em) then
     write (*, '(a)') ' karar: sigma <= sigma_em  (St 37 yeterli; St 52-3 de kullanilabilir)'
  else
     write (*, '(a)') ' karar: sigma > sigma_em  (malzeme yukseltilmeli)'
  end if

  ! ---------------------------------------------------------------------------
  ! [9] Baş kiriş
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[9] Bas kiris: F, M = F*L_B,  W = M/(2*sigma_em)'
  f_bas = bas_kiris_kuvveti(q_kaldirma, g_araba, g_kopru, l_kopru_m, l_araba_min, phi_zati, psi_yuk)
  l_b = (bas_teker_arasi - bas_kiris_arasi) / 2.0_real64 * 100.0_real64
  m_bas = f_bas * l_b
  w_bas = m_bas / (2.0_real64 * sigma_em)
  w_bas_toplam = m_bas / sigma_em
  call satir(' F (yatak kuvveti)', f_bas, 'daN')
  call satir(' L_B = (L_R - L_E)/2', l_b, 'cm')
  call satir(' M = F * L_B', m_bas, 'daN*cm')
  call satir(' W (profil basina)', w_bas, 'cm3')
  call satir(' W (belgedeki yazim)', w_bas_toplam, 'cm3')
  write (*, '(a)') ' secim: belge [260 (Wx = 371 cm3) veya [280 (448 cm3) aliyor -> 2 kat pay'
  write (*, '(a)') ' not: 1/2 carpani uygulanirsa 188 cm3 yeter -> [200 (Wx = 191) de olur.'

  ! ---------------------------------------------------------------------------
  ! [10] Çapraz kontrol
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[10] Capraz kontrol: ayni sayiya ikinci yol'
  etiket = 'buyukluk'
  baslik = etiket
  baslik(26:37) = '       yol A'
  baslik(39:50) = '       yol B'
  baslik(52:59) = '  fark %'
  write (*, '(a)') trim(baslik)
  f_sayisal = sehim_sayisal(l_kopru, elastisite, iz_kesit, g_kopru, q_kaldirma, g_araba, 2, 200)
  sigma_terimli = (phi_zati * m_t) / w_z + (psi_yuk * m_k) / w_z + m_at / w_y
  call capraz(' f_top  [cm]', f_top, f_sayisal)
  call capraz(' sigma  [daN/cm2]', sigma, sigma_terimli)
  call capraz(' M_T    [daN*cm]', m_t, 0.5_real64 * g_kopru * l_kopru / 8.0_real64 + &
       0.5_real64 * g_araba * l_kopru / 4.0_real64)

  write (*, '(a)') ''
  write (*, '(a)') repeat('-', 88)
  write (*, '(a)') 'Ozet: tekerlek caplari 250/500 mm, motorlar 1,58 kW ve 8,44 kW (secim 2x5,5),'
  write (*, '(a)') '      kesit Iz = 354838 cm4 (gerekli 339286), sigma = 96,5 N/mm2 <= 160 (St 37).'

  ! ---------------------------------------------------------------------------
  ! [11] M(x) ve V(x) — Şekil 5'in sayısal karşılığı
  ! ---------------------------------------------------------------------------
  write (*, '(a)') ''
  write (*, '(a)') '[11] M(x) / V(x) - Sekil 5 karsiligi (zati yayili yuk + ortada tekil yuk)'
  write (*, '(a)') '   x/L    V [daN]  M [daN*cm]  M/M_maks'
  m_maks = 0.0_real64
  do i = 0, 10
     x = l_kopru * real(i, real64) / 10.0_real64
     m_x = kesme_momenti(x, l_kopru, g_kopru, q_kaldirma + g_araba)
     m_maks = max(m_maks, m_x)
  end do
  do i = 0, 10
     x = l_kopru * real(i, real64) / 10.0_real64
     v_x = kesme_kuvveti(x, l_kopru, g_kopru, q_kaldirma + g_araba)
     m_x = kesme_momenti(x, l_kopru, g_kopru, q_kaldirma + g_araba)
     write (*, '(f6.2,1x,f9.1,1x,f10.1,1x,a)') x / l_kopru, v_x, m_x, &
          repeat('#', nint(40.0_real64 * m_x / m_maks))
  end do
  write (*, '(a)') ' not: yayili yuk q = G_K/L (iki kirisin toplami), tekil yuk (Q_K+G_A) ortada.'

contains

  ! --- yardımcı yazım --------------------------------------------------------

  subroutine satir(baslik, deger, birim)
    character(len=*), intent(in) :: baslik, birim
    real(real64), intent(in) :: deger
    character(len=38) :: yerel
    yerel = baslik
    write (*, '(a,1x,f14.4,1x,a)') yerel, deger, birim
  end subroutine satir

  subroutine capraz(baslik, yol_a, yol_b)
    character(len=*), intent(in) :: baslik
    real(real64), intent(in) :: yol_a, yol_b
    character(len=24) :: yerel
    real(real64) :: fark
    yerel = baslik
    fark = abs(yol_a - yol_b) / max(abs(yol_a), 1.0e-30_real64) * 100.0_real64
    write (*, '(a,1x,f12.4,1x,f12.4,1x,f8.4)') yerel, yol_a, yol_b, fark
  end subroutine capraz

  ! --- tekerlek ve tahrik ----------------------------------------------------

  pure function basinc_emniyeti(c1) result(p_em)
    ! DIN 15070: p_em = 56 * C1  (daN/cm^2)
    real(real64), intent(in) :: c1
    real(real64) :: p_em
    p_em = 56.0_real64 * c1
  end function basinc_emniyeti

  pure function tekerlek_capi(yuk, p_em, c2, c3, temas_genisligi) result(cap_cm)
    ! D = R / (p_em * C2 * C3 * b)   — b: tekerlek-ray temas genişliği (cm)
    real(real64), intent(in) :: yuk, p_em, c2, c3, temas_genisligi
    real(real64) :: cap_cm
    cap_cm = yuk / (p_em * c2 * c3 * temas_genisligi)
  end function tekerlek_capi

  pure function yurume_direnci(toplam_yuk, d_tekerlek, mu, d_aks, f_kol, emniyet) result(w)
    ! W = n * (G/D) * (mu*d + 2f)  [daN]
    real(real64), intent(in) :: toplam_yuk, d_tekerlek, mu, d_aks, f_kol, emniyet
    real(real64) :: w
    w = emniyet * (toplam_yuk / d_tekerlek) * (mu * d_aks + 2.0_real64 * f_kol)
  end function yurume_direnci

  pure function ivme_direnci(toplam_yuk, g, ivme, emniyet) result(w)
    ! W_iv = n * (G/g) * a  [daN]
    real(real64), intent(in) :: toplam_yuk, g, ivme, emniyet
    real(real64) :: w
    w = emniyet * (toplam_yuk / g) * ivme
  end function ivme_direnci

  pure function guc(w, v_ms, verim) result(kw)
    ! N = W*V/(102*eta)  [kW]   (W daN, V m/s)
    real(real64), intent(in) :: w, v_ms, verim
    real(real64) :: kw
    kw = w * v_ms / (102.0_real64 * verim)
  end function guc

  ! --- kiriş: sehim, kesit, gerilme ------------------------------------------

  pure function kesit_ataket_momenti(b, h_dis, h_ic, govde) result(iz)
    ! I_z = B*(H^3-h^3)/12 + s0*h^3/12   (Şekil 4: iki başlık + gövde)
    real(real64), intent(in) :: b, h_dis, h_ic, govde
    real(real64) :: iz
    iz = b * (h_dis**3 - h_ic**3) / 12.0_real64 + govde * h_ic**3 / 12.0_real64
  end function kesit_ataket_momenti

  pure function gerekli_ataket_momenti(l, e, f_em, g_k, q_k, g_a, adet) result(iz)
    ! Iz = L^3/(48*E*f_em) * [5/8*G_K + (Q_K+G_A)] / adet
    real(real64), intent(in) :: l, e, f_em, g_k, q_k, g_a
    integer(int32), intent(in) :: adet
    real(real64) :: iz
    iz = l**3 / (48.0_real64 * e * f_em) * (5.0_real64 / 8.0_real64 * g_k + q_k + g_a) / real(adet, real64)
  end function gerekli_ataket_momenti

  pure function sehim_toplam(l, e, iz, g_k, q_k, g_a, adet) result(f)
    ! f = L^3/(48*E*Iz) * [5/8*G_K + (Q_K+G_A)] / adet   (basit mesnet, orta nokta)
    real(real64), intent(in) :: l, e, iz, g_k, q_k, g_a
    integer(int32), intent(in) :: adet
    real(real64) :: f
    f = l**3 / (48.0_real64 * e * iz) * (5.0_real64 / 8.0_real64 * g_k + q_k + g_a) / real(adet, real64)
  end function sehim_toplam

  pure function sehim_sayisal(l, e, iz, g_k, q_k, g_a, adet, adim) result(f)
    ! f = integral M(x)*mbar(x)/(E*Iz) dx  — birim yük yöntemi, Simpson (ikinci yol)
    real(real64), intent(in) :: l, e, iz, g_k, q_k, g_a
    integer(int32), intent(in) :: adet, adim
    real(real64) :: f, x, h, agirlik, toplam
    integer(int32) :: i
    h = l / real(adim, real64)
    toplam = 0.0_real64
    do i = 0, adim
       x = real(i, real64) * h
       if (i == 0 .or. i == adim) then
          agirlik = 1.0_real64
       else if (mod(i, 2) == 0) then
          agirlik = 2.0_real64
       else
          agirlik = 4.0_real64
       end if
       toplam = toplam + agirlik * kesme_momenti(x, l, g_k, q_k + g_a) / real(adet, real64) * birim_moment(x, l)
    end do
    f = toplam * h / 3.0_real64 / (e * iz)
  end function sehim_sayisal

  pure function birim_moment(x, l) result(mbar)
    ! Ortada birim yük altında moment: x <= L/2 -> x/2
    real(real64), intent(in) :: x, l
    real(real64) :: mbar
    if (x <= l / 2.0_real64) then
       mbar = x / 2.0_real64
    else
       mbar = (l - x) / 2.0_real64
    end if
  end function birim_moment

  pure function kesme_momenti(x, l, g_k, tekil) result(m)
    ! Yayılı q = G_K/L + ortada tekil yük P: M(x)
    real(real64), intent(in) :: x, l, g_k, tekil
    real(real64) :: m, q
    q = g_k / l
    m = q * x * (l - x) / 2.0_real64
    if (x <= l / 2.0_real64) then
       m = m + tekil * x / 2.0_real64
    else
       m = m + tekil * (l - x) / 2.0_real64
    end if
  end function kesme_momenti

  pure function kesme_kuvveti(x, l, g_k, tekil) result(v)
    ! V(x) = q*(L/2 - x) ± P/2
    real(real64), intent(in) :: x, l, g_k, tekil
    real(real64) :: v, q
    q = g_k / l
    v = q * (l / 2.0_real64 - x)
    if (x < l / 2.0_real64) then
       v = v + tekil / 2.0_real64
    else if (x > l / 2.0_real64) then
       v = v - tekil / 2.0_real64
    end if
  end function kesme_kuvveti

  ! --- baş kiriş -------------------------------------------------------------

  pure function bas_kiris_kuvveti(q_k, g_a, g_k, l_m, l_a, phi, psi) result(f)
    ! F = 1/2 * [ Q_K*psi*(L-La)/L + G_A*phi*(L-La)/L + G_K*phi/2 ]
    real(real64), intent(in) :: q_k, g_a, g_k, l_m, l_a, phi, psi
    real(real64) :: f, oran
    oran = (l_m - l_a) / l_m
    f = 0.5_real64 * (q_k * psi * oran + g_a * phi * oran + 0.5_real64 * g_k * phi)
  end function bas_kiris_kuvveti

end program gezer_kren_hesabi
