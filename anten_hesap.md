# HF Anten Hesabı — Tel Boyu, Unun ve Ferrit Çubuk (`anten_hesap`)

Bu örnek, bir **yazılım tanımlı radyo** (SDR) alıcısı için HF/LF anteninin sayılarını üreten
tek dosyalık bir hesap programıdır: tel boyunun dalga boyuna oranı, toroid **unun** (unun =
unbalanced-to-unbalanced transformatör) endüktansı ve reaktansı, **uyumsuzluk kaybı**, ferrit
çubuk rezonansı ve bobin **Q**'sundan kayıp direnci ile bant genişliği.

Programın kuralı şudur: **hiçbir sayı elle yazılmaz.** Tablodaki her değer, dosyanın içindeki
bir formülden üretilir; sabitler `parameter` olarak tek yerde durur. Bu yüzden bir varsayım
(örneğin ferrit çubuğun geçirgenliği) değiştiğinde tüm tablo tutarlı biçimde yenilenir.

> Aynı hesabın **GNU Octave** sürümü kardeş depoda durur:
> [`anten_hesap`](https://onkanat.github.io/Octave_TR_Doc/anten_hesap.html).
> İki dilin çıktısı **57 satırda birebir aynıdır** — bu, iki bağımsız gerçeklemenin aynı
> formülü kullandığının kanıtıdır (fizik modelinin kanıtı değil; aşağıdaki sınırlar bölümüne bakın).

## Amaç ve Kapsam

- `lambda = c / f` ile **tel boyu sınıfı**: tel 0,25 λ bölgesinde mi (düşük empedans), 0,5 λ
  bölgesinde mi (yüksek empedans)?
- Toroid unun: `L = AL·N²` ve `X_L = 2·pi·f·L` — sarım sayısı seçiminin ölçütü.
- **Uyumsuzluk kaybı**: ideal trafo oranına göre dB cinsinden kayıp; ters çözümle "bilinen
  kayıptan empedans" hesabı.
- Ferrit çubuk: `L = k·mu0·mu_r·N²·A/l` ve `f = 1/(2·pi·sqrt(L·C))` — NAVTEX 490/518 kHz.
- Bobin Q'su: kayıp direnci `R = X_L/Q` ve bant genişliği `BW = f/Q`.
- **Çapraz kontrol**: her kritik sayıya ikinci, cebirsel olarak farklı yoldan varma.

Kapsam dışı: verici (TX) eşlemesi, çekirdek kaybı, ölçüm (LCR metre / nanoVNA / `rtl_power`).
Bu program **hesap** üretir, **ölçüm** değil.

## Hesap Zinciri (formüller)

| Büyüklük | Formül | Programdaki fonksiyon |
|---|---|---|
| Dalga boyu | `lambda = c / f` | `dalga_boyu` |
| Tel boyu oranı | `L_tel / lambda` | `boy_orani` |
| Toroid endüktansı | `L = AL * N^2` | `enduktans_toroid` |
| Reaktans | `X_L = 2 * pi * f * L` | `reaktans` |
| Çubuk endüktansı | `L = k * mu0 * mu_r * N^2 * A / l` | `enduktans_cubuk` |
| Rezonans | `f = 1 / (2 * pi * sqrt(L * C))` | `rezonans_frekansi` |
| Rezonans sığası | `C = 1 / ((2 * pi * f)^2 * L)` | `rezonans_sigasi` |
| Uyumsuzluk kaybı | `-10 * log10(4 * Z1 * Z2 / (Z1 + Z2)^2)` | `uyumsuzluk_kaybi` |
| Trafo | `Z_giris = Z_yuk / oran` | `trafo` |
| Kayıp direnci | `R = X_L / Q` | `kayip_direnci` |
| Bant genişliği | `BW = f / Q` | `bant_genisligi` |

Sabitler: `c = 299792458` m/s (**tam**; `300/f` yaklaşımı kullanılmaz), `AL = 1075` nH/N²,
`mu0 = 4*pi*1e-7` H/m, sistem empedansı 50 Ω, kıyas çizgisi 450 Ω.

## Derleme ve Çalıştırma

```sh
gfortran anten_hesap.f90 -o anten_hesap
./anten_hesap
```

Program **girdi istemez** (etkileşimsizdir): sabitler dosyanın başında tanımlıdır, çıktı iki
koşuda birebir aynıdır. Bu yüzden CI'da ya da bir betik içinde doğrudan koşulabilir.

## Beklenen Çıktı

Aşağıdaki blok, `gfortran -Wall -Wextra -pedantic -fcheck=all` ile derlenmiş programın
**gerçek koşusundan** alınmıştır (elle yazılmadı):

```text
====================================================================================
ANTEN HESABI - HF tel boyu, unun (toroid) ve ferrit cubuk
c = 299792458 m/s | AL = 1075 nH/N^2 | mu0 = 4*pi*1e-7 | Z_sistem = 50 ohm
====================================================================================

[1] Tel boyu ve dalga boyu: lambda = c / f  (isik hizi tam)
 f [MHz]   lambda [m]  lambda/2 [m]   20 m/lambda  39 m/lambda
   3.500       85.655        42.827         0.2335       0.4553
   3.855       77.767        38.884         0.2572       0.5015
   7.000       42.827        21.414         0.4670       0.9106
   7.880       38.045        19.022         0.5257       1.0251
  14.000       21.414        10.707         0.9340       1.8213
 not: ~0,5 lambda = yuksek empedans (unun ister), ~0,25 lambda = dusuk empedans.

[2] Toroid: L = AL*N^2 ve X_L = 2*pi*f*L   (AL = 1075 nH/N^2)
  N    L [uH]   X_L@3.500 [ohm]   /450x   X_L@3.855 [ohm]   /450x
 12   154.800           3404.2    7.56           3749.5    8.33
 14   210.700           4633.5   10.30           5103.5   11.34
 kural: en dusuk frekansta X_L, 450 ohm'un en az 5-10 kati olmali.

[3] Uyumsuzluk kaybi: -10*log10(4*Z1*Z2/(Z1+Z2)^2),  Z2 = Z_yuk / oran
 Z_yuk     1:1 [dB]    9:1 [dB]   49:1 [dB]
    25         0.51        7.00       13.98
    40         0.05        5.23       11.99
    80         0.24        2.90        9.12
   150         1.25        1.25        6.63
  1000         7.41        0.67        0.84
  2000        10.21        2.22        0.04
  3000        11.90        3.43        0.04
  5000        14.07        5.19        0.54
 bolge: 25-150 ohm = lambda/4 (dusuk Z), 1000-5000 ohm = lambda/2 (yuksek Z).
 oran secimi Z'den bagimsiz: lambda/2 -> 49:1, lambda/4 -> 1:1; kayip ise Z'ye bagli.
 ters cozum: 0.02 dB -> Z_trafo =  57.271 ohm -> Z_tel =   515.441 ohm (9:1 icin; diger kok  43.652 ohm)

[4] Ferrit cubuk: L = k*mu0*mu_r*N^2*A/l  (l = 100 mm, d = 8 mm, mu_r = 400, k = 0.6)
 N = 79 -> L =  946.118 uH | A =   50.265 mm^2
 C = 100 pF -> f_rez =  517.4252 kHz
 490 kHz icin C =  111.507 pF | 518 kHz icin C =   99.778 pF

[5] Bobin Q -> kayip direnci ve bant genisligi  (L = 944 uH @ 518 kHz)
 X_L =     3072.4 ohm
   Q   R_kayip [ohm]    BW [kHz]
 100          30.72      5.180
 150          20.48      3.453
 200          15.36      2.590
 not: NAVTEX kanali ~1 kHz, komsu kanal 28 kHz uzakta -> 2-6 kHz yeterli.

[6] Capraz kontrol: ayni sayiya ikinci yol (kapali form <-> kok arama)
buyukluk                                 yol A       yol B   fark %
f_rez (946.118 uH, 100 pF) [kHz]      517.4252    517.4252   0.0000
BW Q=100 (944 uH, 518 kHz) [kHz]        5.1800      5.1800   0.0000
BW Q=200 (944 uH, 518 kHz) [kHz]        2.5900      2.5900   0.0000
9:1 kaybi Z=2000 ohm [dB]               2.2203      2.2203   0.0000

------------------------------------------------------------------------------------
Ozet: 5 frekans x 4 buyukluk, 2 toroid, 8 yuk x 3 oran, 1 cubuk, 3 Q
      hesaplandi; 4 capraz kontrol TUTARLI. Sayilar formulden, elle yazilmadi.
```

## Kodun Detaylı Açıklaması

Sabitler tek yerde ve `parameter`: böylece bir sayı değişince tüm tablo yenilenir, "gizli sabit"
kalmaz.

```fortran
real(real64), parameter :: isik_hizi = 299792458.0_real64          ! m/s (tam)
real(real64), parameter :: al_nh = 1075.0_real64                   ! nH/N^2 (toroid çekirdek)
real(real64), parameter :: mu0 = 4.0_real64 * pi * 1.0e-7_real64   ! H/m
real(real64), parameter :: z_sistem = 50.0_real64                  ! koaksiyel sistem empedansı
```

Çekirdek formüller `pure function`: aynı girdiye her zaman aynı çıktı, yan etki yok.

```fortran
pure function dalga_boyu(frekans_hz) result(metre)
  real(real64), intent(in) :: frekans_hz
  real(real64) :: metre
  metre = isik_hizi / frekans_hz
end function dalga_boyu

pure function uyumsuzluk_kaybi(z1, z2) result(db)
  real(real64), intent(in) :: z1, z2
  real(real64) :: db
  db = -10.0_real64 * log10(4.0_real64 * z1 * z2 / (z1 + z2)**2)
end function uyumsuzluk_kaybi
```

**Ters çözüm** — "kayıp 0,02 dB ise yük empedansı kaç ohm?" sorusu ikinci derece denkleme
dönüşür: `4r/(1+r)^2 = 10^(-k/10)` eşitliğinden `r^2 - b*r + 1 = 0` ve iki kök çıkar.

```fortran
pure subroutine kayiptan_empedans(kayip_db, z_buyuk, z_kucuk)
  real(real64), intent(in) :: kayip_db
  real(real64), intent(out) :: z_buyuk, z_kucuk
  real(real64) :: dogrusal, b, diskriminant
  dogrusal = 10.0_real64 ** (-kayip_db / 10.0_real64)
  b = 4.0_real64 / dogrusal - 2.0_real64
  diskriminant = sqrt(max(b * b - 4.0_real64, 0.0_real64))
  z_buyuk = z_sistem * (b + diskriminant) / 2.0_real64
  z_kucuk = z_sistem * (b - diskriminant) / 2.0_real64
end subroutine kayiptan_empedans
```

**İkinci yol (çapraz kontrol)**: rezonans frekansı, kapalı formül kullanılmadan, reaktansların
eşitlendiği noktanın **ikiye bölme** ile aranmasıyla da bulunur. İki yolun aynı sayıyı vermesi
formülün doğruluğunu değil, **kodun** doğru yazıldığını gösterir.

```fortran
pure function rezonans_koku(enduktans_h, siga_f) result(hertz)
  ! 1/(2*pi*sqrt(L*C)) formülünü KULLANMAZ: X_L(f) - X_C(f) = 0 kökünü arar.
  real(real64), intent(in) :: enduktans_h, siga_f
  real(real64) :: hertz, alt, ust, orta
  integer(int32) :: adim
  alt = 1.0e3_real64          ! X_L < X_C olan alt uç
  ust = 5.0e7_real64          ! X_L > X_C olan üst uç
  do adim = 1, 200
     orta = sqrt(alt * ust)                 ! logaritmik ikiye bölme
     if (reaktans_farki(orta, enduktans_h, siga_f) <= 0.0_real64) then
        alt = orta
     else
        ust = orta
     end if
  end do
  hertz = sqrt(alt * ust)
end function rezonans_koku
```

Bant genişliğinin ikinci yolu `f/Q` değil, seri RLC'de `|Z(f)| = sqrt(2) * R` yarı güç
noktalarının aranmasıdır:

```fortran
pure function empedans_buyuklugu(frekans_hz, enduktans_h, siga_f, r_kayip) result(ohm)
  ohm = sqrt(r_kayip**2 + reaktans_farki(frekans_hz, enduktans_h, siga_f)**2)
end function empedans_buyuklugu
```

### Öne Çıkan Noktalar

1. `implicit none` ve `use, intrinsic :: iso_fortran_env, only: real64, int32`: tür ve hassasiyet
   taşınabilir biçimde sabitlenir.
2. Tüm çekirdek fonksiyonlar `pure`: derleyici bunları saflaştırabilir, yan etkisizlik garanti edilir.
3. `a34` düzen belirteci metni **sağa** yaslar; sola yaslamak için etiket `character(len=34)`
   değişkene atanır (atama sağdaki boşlukları doldurur) — `[6]` tablosunun hizası bundandır.
4. `[3]` tablosundaki iç içe `do` (`(... , j = 1, size(oranlar))`) üç oranı tek `write` ile yazar.
5. Program etkileşimsizdir: `read` yok, `stop` yok; çıktı iki koşuda birebir aynı.
6. Aynı hesap kardeş depoda GNU Octave ile de yazılmıştır; iki çıktının **57 satırı birebir**
   aynıdır — dil değil, formül aynı olduğu için.

## Doğrulama ve Sınırlar

Bu tabloların kanıt değeri **formüllerin açık yazılmış olmasından** ve **çapraz kontrolden** gelir;
ölçümün yerini tutmaz:

- Ferrit çubukta `mu_r = 400` ve `k = 0,6` **varsayımdır** (üretici verisi yok). Mutlak `L`
  değeri ±%10 mertebesinde kayabilir; rezonans `sqrt(L)` ile gittiği için sapma yarıya iner.
- Trafo **ideal** (kayıpsız) varsayıldı: gerçek ununda çekirdek kaybı ayrı bir eksendir.
- 450 Ω bir **normalizasyon çizgisidir**, hedef empedans değil.
- Telin besleme empedansı modellenmemiştir: bu yüzden kayıp **tek sayı** değil **aralık** olarak
  okunmalıdır (λ/2 bölgesinde 1000–5000 Ω, λ/4 bölgesinde 25–150 Ω).
- Yorum: 20 m tel 3,855 MHz'de `20 / 77,767 = 0,257` λ (λ/4 bölgesi → düşük empedans),
  7,880 MHz'de `0,526` λ (λ/2 bölgesi → yüksek empedans). Oran seçimi bu sınıfa bağlıdır;
  kayıp ise gerçek (ölçülmemiş) `Z`'ye.
- Gerçek doğrulama ölçümdür: sarım sonrası endüktans (LCR metre) ve rezonans (alıcıyla tepe
  araması), ardından anten öncesi/sonrası SNR karşılaştırması.

## Alıştırmalar ve İpuçları

1. `frekanslar_mhz` dizisine **21.0** ve **28.0** ekleyin. 20 m tel bu frekanslarda kaç λ olur;
   desen lob'lu hale gelir mi?
2. `cubuk_mur` değerini 100 / 400 / 800 yapın. Endüktans `mu_r` ile **doğru**, rezonans
   `sqrt(mu_r)` ile **ters** orantılı mı? Tablodan doğrulayın.
3. `[3]` tablosunu 450 Ω yerine 200 Ω'a normalize edin (`z_referans`): `X_L/450` sütunu nasıl değişir,
   seçim ölçütü (5–10 kat) bozulur mu?
4. `[3]` tablosuna **39 m tel** senaryosunu ekleyin: 3,855 MHz'de `0,501` λ, 7,880 MHz'de `1,025` λ —
   ikisi de **yüksek empedans** bölgesi. Hangi oran iki bantta birden 0 dB'e yakın kalıyor?
   (İpucu: tek tel iki bandı ancak tek oranla kapsıyorsa o oran hangisidir?)
5. Çıktıyı CSV'ye yazın: `open(newunit=u, file="anten.csv", status="replace", iostat=io, iomsg=msg)`
   güvenli şablonuyla (bkz. [`robust_file_io.md`](./robust_file_io.md)).
6. `yari_guc_noktasi` içindeki ikiye bölme adımını 20'ye düşürün: `fark %` sütunu ne olur? Bu,
   "yakınsama" ile "doğru formül" arasındaki farkı gösterir.
