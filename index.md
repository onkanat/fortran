---
layout: default
title: "Fortran Çalışma Notları"
lang: tr
tur: katalog
eyebrow: "EĞİTİM · FORTRAN · KATALOG"
---

# Fortran Çalışma Notları

Bu belge, Modern Fortran öğrenirken alınan notlar ve örnekler için bir başlangıç noktasıdır.
Projenin genel yapısı ve standartları için [GEMINI.md](./GEMINI.md) dosyasına göz atabilirsiniz.

Her **kod çifti** aynı adlı iki dosyadır: `ad.md` (anlatım) + `ad.f90` (derlenen kaynak).
**Kavram notları** salt anlatımdır; kod çifti yoktur ve `tur: kavram` etiketiyle işaretlenir.

## Katalog — kod çiftleri {#katalog}

### Temel dil ve içsel fonksiyonlar

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Dinamik Dizi ile Ortalama Alma](./main.md) | [`main.f90`](./main.f90) | `allocatable`, `allocate`, `sum/count` ve maske kullanımı. |
| [MERGE Fonksiyonu](./demo_merge.md) | [`demo_merge.f90`](./demo_merge.f90) | `MERGE` içsel fonksiyonu (skaler + dizi), maske ile seçim. |
| [ABS Fonksiyonu](./demo_abs.md) | [`demo_abs.f90`](./demo_abs.f90) | `ABS` fonksiyonu (tamsayı/gerçek/karmaşık). |

### Diziler

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Standard Deviation Programı](./standard_deviation.md) | [`standard_deviation.f90`](./standard_deviation.f90) | dosyadan sayıları okuyup temel istatistikleri hesaplayan örnek. |
| [Pure/Elemental Fonksiyonlar](./pure_elemental_demo.md) | [`pure_elemental_demo.f90`](./pure_elemental_demo.f90) | `pure` ve `elemental` ile dizi üzerinde eleman-bazlı işlem. |

### Metin (string) işleme

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Case Converter](./case_converter.md) | [`case_converter.f90`](./case_converter.f90) | küçük harfleri büyük harfe dönüştürme örneği. |
| [Metin Ayrıştırma](./string_parsing.md) | [`string_parsing.f90`](./string_parsing.f90) | `character(len=:), allocatable`, `trim/adjustl/index`, string içinden `read`. |

### Kontrol akışı ve doğrulama

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [İkinci Dereceden Denklem Çözücü](./quadratic.md) | [`quadratic.f90`](./quadratic.f90) | `if/else if/else`, tolerans, gerçek/karmaşık kökler. |
| [Not Harfi Atama](./grades.md) | [`grades.f90`](./grades.f90) | `select case` ve aralık kullanımı. |
| [Tarih Doğrulama](./date_check.md) | [`date_check.f90`](./date_check.f90) | döngü + `exit/cycle` + ay bazlı doğrulama. |

### Döngüler

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Karelerin Toplamı vs. Toplamın Karesi](./sos_difference.md) | [`sos_difference.f90`](./sos_difference.f90) | sayaç kontrollü `do` döngüsü. |

### Fonksiyonlar ve prosedürler

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Kare Fonksiyonu](./square_function.md) | [`square_function.f90`](./square_function.f90) | fonksiyon tanımı ve kullanımı. |
| [Fonksiyon Örnekleri](./function_examples.md) | [`function_examples.f90`](./function_examples.f90) | `contains` ile internal fonksiyonlar. |

### Dosya G/Ç

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Güvenli Dosya G/Ç](./robust_file_io.md) | [`robust_file_io.f90`](./robust_file_io.f90) | `open(newunit=...)`, `iostat/iomsg`, formatlı yazma ve geri okuma. |

### Modüller ve taşınabilirlik

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [İstatistik Modülü](./statistics_utils.md) | [`statistics_utils.f90`](./statistics_utils.f90) | `module`, `public/private`, `pure`, `generic interface`. |
| [Modül Kullanımı Demo](./statistics_module_demo.md) | [`statistics_module_demo.f90`](./statistics_module_demo.f90) | modülü kullanarak `mean/stddev` çağırma. |
| [`iso_fortran_env` Demo](./iso_fortran_env_demo.md) | [`iso_fortran_env_demo.f90`](./iso_fortran_env_demo.f90) | `real64/int32`, `output_unit/error_unit` gibi taşınabilir tanımlar. |
| [Komut Satırı Argümanları](./command_line_args_demo.md) | [`command_line_args_demo.f90`](./command_line_args_demo.f90) | `get_command_argument`, `command_argument_count`. |

### Derived type (OOP temelleri)

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Measurement Series](./measurement_series_demo.md) | [`measurement_series_demo.f90`](./measurement_series_demo.f90) | `type`, `allocatable` bileşen, type-bound procedures. |

### Uygulamalı örnekler (makine/metal)

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Kesme Formülleri](./cutting_formules.md) | [`cutting_formules.f90`](./cutting_formules.f90) | kesme hızı (Vc) hesaplama. |
| [Gelişmiş Kesme Formülleri](./cutting_formules_enhanced.md) | [`cutting_formules_enhanced.f90`](./cutting_formules_enhanced.f90) | Vc↔rpm çift yönlü hesap. |
| [Sarkacın Periyodu](./pendulum.md) | [`pendulum.f90`](./pendulum.f90) | periyot hesabı. |

### Harici kütüphaneler

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Sinüs Fonksiyonu Üretimi](./sine.md) | [`sine.f90`](./sine.f90) | `neural-fortran` ile sinir ağı örneği. |

### İleri konular

| Not | Kod | Ne anlatıyor |
|---|---|---|
| [Mandelbrot Seti](./Mandelbrot.md) | [`Mandelbrot.f90`](./Mandelbrot.f90) | modüler tasarım örneği (modüller: [mandelbrot_types.f90](./mandelbrot_types.f90), [mandelbrot_constants.f90](./mandelbrot_constants.f90), [mandelbrot_utils.f90](./mandelbrot_utils.f90)). |
| [Mandelbrot Tür Tanımları](./mandelbrot_types.md) | [`mandelbrot_types.f90`](./mandelbrot_types.f90) | modül: türetilmiş türler (`type`). |
| [Mandelbrot Sabitleri](./mandelbrot_constants.md) | [`mandelbrot_constants.f90`](./mandelbrot_constants.f90) | modül: sabitler (`parameter`). |
| [Mandelbrot Yardımcı Rutinleri](./mandelbrot_utils.md) | [`mandelbrot_utils.f90`](./mandelbrot_utils.f90) | modül: hesaplama yardımcıları. |
| [`do concurrent` Demo](./do_concurrent_demo.md) | [`do_concurrent_demo.f90`](./do_concurrent_demo.f90) | paralelleştirilebilir bağımsız döngü deseni. |
| [`iso_c_binding` ile C çağrısı](./iso_c_binding_add.md) | [`iso_c_binding_add.f90`](./iso_c_binding_add.f90) | C fonksiyonu çağırma (C dosyası: `iso_c_binding_add.c`). |

**29 kod çifti.** Her çift derlenip çalıştırılmıştır; notun "Beklenen Çıktı" bloğu gerçek koşudan alınmıştır.

## Kavram notları (kod çifti yok) {#kavram-notlari}

| Not | Ne anlatıyor |
|---|---|
| [Temel Elemanlar](./fortran_basic_elements.md) | değişkenler, türler, sabitler ve dilin temel öğeleri. |
| [Program Geliştirme Metodolojisi](./program_development.md) | problem → algoritma → uygulama → test adımları, sarkacın periyodu örneğiyle. |
| [Karakterler ve Stringler](./characters_and_strings.md) | karakter sabitleri, alt diziler, karşılaştırmalar ve içsel karakter fonksiyonları. |
| [Dosya İşlemleri](./file_operations.md) | dosya açma, yazma/okuma, rewind/backspace/close, satır numaralama. |
| [Formatlı Giriş/Çıkış](./format_input_output.md) | format tanımlayıcıları, veri türlerine göre biçimlendirme, ileri I/O teknikleri. |
| [Tek Boyutlu Diziler](./single_dimension_arrays.md) | dizi bildirimi, okuma/yazma, min/max/ortalama/standart sapma örneği. |

**6 kavram notu** (`tur: kavram`). Bunlar dilin kavramlarını anlatır; çalıştırılacak bir betikleri yoktur, karşılık gelen kod çiftleri katalogda listelenmiştir.

## macOS için Kurulum

`gfortran` derleyicisini macOS'a kurmanın en kolay yolu [Homebrew](https://brew.sh/) paket yöneticisini kullanmaktır.
`gfortran`, GCC (GNU Fortran Compiler) paketinin bir parçasıdır.

Terminalinizi açın ve şu komutu çalıştırın:
```sh
brew install gcc
```
Homebrew kurulumu tamamlandıktan sonra `gfortran` komutunu sistem PATH'inize otomatik olarak ekler.
Genellikle ek bir PATH ayarı yapmanız gerekmez.

Kurulumu doğrulamak için terminalde şu komutu çalıştırabilirsiniz:
```sh
gfortran --version
```
Bu komut, yüklü olan `gfortran` derleyicisinin sürüm bilgisini göstermelidir.

## İlk Program: Merhaba Dünya

Bu repo için ilk örnek olarak dinamik (allocatable) dizi kullanarak ortalama alma örneği seçilmiştir. Kod `main.f90` dosyasındadır.

Detaylı açıklama: [main.md](./main.md) (kod: [main.f90](./main.f90))

**Programı Derleme ve Çalıştırma**

1. **Derleme**: `gfortran` komutunu kullanarak kaynak kodunu derleyin.
   `-o hello` seçeneği, çıktı dosyasının adını belirler.
   ```sh
   gfortran main.f90 -o hello
   ```
2. **Çalıştırma**: Derleme başarılı olursa bulunduğunuz dizinde `hello` adında bir dosya oluşur.
   ```sh
   ./hello
   ```

Ekran çıktısı olarak `"Hello, World!"` görmelisiniz.

## Çalışma Notları Taslağı

Aşağıdaki taslağı kullanarak kendi notlarınızı tutabilirsiniz.

### Konu: [Konu Başlığını Buraya Yazın]

**Tarih**: 2025-12-06

**Öğrenilen Temel Kavramlar**:
- Kavram 1...
- Kavram 2...
- Kavram 3...

**Örnek Kod**:
```fortran
! ilgili kod parçacığı
program MyExample
  ! ...
end program MyExample
```

**Notlar ve Gözlemler**:
- Bu konuyla ilgili önemli detay.
- Karşılaşılan zorluklar veya kafa karıştırıcı noktalar.
- Gelecekte tekrar gözden geçirilmesi gerekenler.

### Kaynaklar

- [Modern Fortran (GitHub)](https://github.com/modern-fortran/)
- [Fortran-lang](https://fortran-lang.org/)
- [Fortran-lang GitHub](https://github.com/fortran-lang)
