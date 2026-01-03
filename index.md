
---
layout: page
title: "Fortran Çalışma Notları"
toc: false
---

Bu belge, Modern Fortran öğrenirken alınan notlar ve örnekler için bir başlangıç noktasıdır. Projenin genel yapısı ve standartları için [GEMINI.md](./GEMINI.md) dosyasına göz atabilirsiniz.


## macOS için Kurulum

`gfortran` derleyicisini macOS'a kurmanın en kolay yolu [Homebrew](https://brew.sh/) paket yöneticisini kullanmaktır. `gfortran`, GCC (GNU Compiler Collection) paketinin bir parçasıdır.

Terminalinizi açın ve aşağıdaki komutu çalıştırın:
```sh
brew install gcc
```
Homebrew kurulumu tamamladıktan sonra, `gfortran` komutunu sistem PATH'inize otomatik olarak ekler. Genellikle ek bir PATH ayarı yapmanız gerekmez.

Kurulumu doğrulamak için terminalde şu komutu çalıştırabilirsiniz:
```sh
gfortran --version
```
Bu komut, yüklü olan `gfortran` derleyicisinin sürüm bilgisini göstermelidir.

## İlk Program: Merhaba Dünya

Bu repo için ilk örnek olarak dinamik (allocatable) dizi kullanarak ortalama alma örneği seçilmiştir. Kod `main.f90` dosyasındadır.

Detaylı açıklama: [main.md](./main.md) (kod: [main.f90](./main.f90))

**Programı Derleme ve Çalıştırma**

1.  **Derleme**: `gfortran` komutunu kullanarak kaynak kodunu derleyin. `-o hello` seçeneği, derleyiciye çalıştırılabilir dosyanın adının `hello` olmasını söyler.
    ```sh
    gfortran main.f90 -o hello
    ```

2.  **Çalıştırma**: Derleme başarılı olursa, bulunduğunuz dizinde `hello` adında bir dosya oluşur. Bu dosyayı çalıştırın:
    ```sh
    ./hello
    ```

Ekran çıktısı olarak `"Hello, World!"` görmelisiniz.

## Örnekler

Bu depodaki daha karmaşık örnekleri inceleyebilirsiniz.

- **[Dinamik Dizi ile Ortalama Alma](./main.md)** (kod: [main.f90](./main.f90)): `allocatable`, `allocate`, `sum/count` ve maske kullanımı.

### Temel dil özellikleri ve içsel fonksiyonlar

- **[MERGE Fonksiyonu](./demo_merge.md)** (kod: [demo_merge.f90](./demo_merge.f90)): `MERGE` içsel fonksiyonu (skaler + dizi), maske ile seçim.
- **[ABS Fonksiyonu](./demo_abs.md)** (kod: [demo_abs.f90](./demo_abs.f90)): `ABS` fonksiyonu (tamsayı/gerçek/karmaşık).

### Diziler

- **[Tek Boyutlu Diziler](./single_dimension_arrays.md)**: tek boyutlu dizi bildirimi, okuma/yazma, min/max/ortalama/standart sapma örneği.
- **[Standard Deviation Programı](./standard_deviation.md)** (kod: [standard_deviation.f90](./standard_deviation.f90)): dosyadan sayıları okuyup temel istatistikleri hesaplayan örnek.

### Metin (string) işleme

- **[Karakterler ve Stringler](./characters_and_strings.md)**: karakter sabitleri, alt diziler, karşılaştırmalar ve içsel fonksiyonlar.
- **[Case Converter](./case_converter.md)** (kod: [case_converter.f90](./case_converter.f90)): küçük harfleri büyük harfe dönüştürme örneği.
- **[Metin Ayrıştırma](./string_parsing.md)** (kod: [string_parsing.f90](./string_parsing.f90)): `character(len=:), allocatable`, `trim/adjustl/index`, string içinden `read`.

### Kontrol akışı ve doğrulama

- **[İkinci Dereceden Denklem Çözücü](./quadratic.md)** (kod: [quadratic.f90](./quadratic.f90)): `if/else if/else`, tolerans, gerçek/karmaşık kökler.
- **[Not Harfi Atama](./grades.md)** (kod: [grades.f90](./grades.f90)): `select case` ve aralık kullanımı.
- **[Tarih Doğrulama](./date_check.md)** (kod: [date_check.f90](./date_check.f90)): döngü + `exit/cycle` + ay bazlı doğrulama.

### Döngüler

- **[Karelerin Toplamı vs. Toplamın Karesi](./sos_difference.md)** (kod: [sos_difference.f90](./sos_difference.f90)): sayaç kontrollü `do` döngüsü.

### Fonksiyonlar ve prosedürler

- **[Kare Fonksiyonu](./square_function.md)** (kod: [square_function.f90](./square_function.f90)): fonksiyon tanımı ve kullanımı.
- **[Fonksiyon Örnekleri](./function_examples.md)** (kod: [function_examples.f90](./function_examples.f90)): `contains` ile internal fonksiyonlar.
- **[Pure/Elemental Fonksiyonlar](./pure_elemental_demo.md)** (kod: [pure_elemental_demo.f90](./pure_elemental_demo.f90)): `pure` ve `elemental` ile dizi üzerinde eleman-bazlı işlem.

### Dosya G/Ç (File I/O)

- **[Güvenli Dosya G/Ç](./robust_file_io.md)** (kod: [robust_file_io.f90](./robust_file_io.f90)): `open(newunit=...)`, `iostat/iomsg`, formatlı yazma ve geri okuma.
- **[Dosya İşlemleri Rehberi](./file_operations.md)**: dosya açma, yazma/okuma, rewind/backspace/close ve satır numaralama örneği.

## P1: Modüler Programlama ve Daha Modern Yapılar

### `iso_fortran_env` ve komut satırı

- **[`iso_fortran_env` Demo](./iso_fortran_env_demo.md)** (kod: [iso_fortran_env_demo.f90](./iso_fortran_env_demo.f90)): `real64/int32`, `output_unit/error_unit` gibi taşınabilir tanımlar.
- **[Komut Satırı Argümanları](./command_line_args_demo.md)** (kod: [command_line_args_demo.f90](./command_line_args_demo.f90)): `get_command_argument`, `command_argument_count`.

### Modüller ve generic interface

- **[İstatistik Modülü](./statistics_utils.md)** (kod: [statistics_utils.f90](./statistics_utils.f90)): `module`, `public/private`, `pure`, `generic interface`.
- **[Modül Kullanımı Demo](./statistics_module_demo.md)** (kod: [statistics_module_demo.f90](./statistics_module_demo.f90)): modülü kullanarak `mean/stddev` çağırma.

### Derived type (OOP temelleri)

- **[Measurement Series](./measurement_series_demo.md)** (kod: [measurement_series_demo.f90](./measurement_series_demo.f90)): `type`, `allocatable` bileşen, type-bound procedures.

### Uygulamalı örnekler

- **[Kesme Formülleri](./cutting_formules.md)** (kod: [cutting_formules.f90](./cutting_formules.f90)): kesme hızı (Vc) hesaplama.
- **[Gelişmiş Kesme Formülleri](./cutting_formules_enhanced.md)** (kod: [cutting_formules_enhanced.f90](./cutting_formules_enhanced.f90)): Vc↔rpm çift yönlü hesap.
- **[Sarkacın Periyodu](./pendulum.md)** (kod: [pendulum.f90](./pendulum.f90)): periyot hesabı.

### Harici kütüphaneler

- **[Sinüs Fonksiyonu Üretimi](./sine.md)** (kod: [sine.f90](./sine.f90)): `neural-fortran` ile sinir ağı örneği.

### İleri konular (taslak)

- **[Mandelbrot Seti](./Mandelbrot.md)** (kod: [Mandelbrot.f90](./Mandelbrot.f90)): modüler tasarım örneği (modüller: [mandelbrot_types.f90](./mandelbrot_types.f90), [mandelbrot_constants.f90](./mandelbrot_constants.f90), [mandelbrot_utils.f90](./mandelbrot_utils.f90)).

### P2: Seçilmiş ileri konular

- **[`do concurrent` Demo](./do_concurrent_demo.md)** (kod: [do_concurrent_demo.f90](./do_concurrent_demo.f90)): paralelleştirilebilir bağımsız döngü deseni.
- **[`iso_c_binding` ile C çağrısı](./iso_c_binding_add.md)** (kod: [iso_c_binding_add.f90](./iso_c_binding_add.f90)): C fonksiyonu çağırma (C dosyası: `iso_c_binding_add.c`).

### Rehberler

- **[Fortran Temel Kavramları](./fortran_basic_elements.md)**: dilin temel öğeleri.
- **[Program Geliştirme Notları](./program_development.md)**: seçim ifadeleri, güvenli girdi, döngüler ve alıştırmalar.

### Kaynaklar

- [Modern Fortran (GitHub)](https://github.com/modern-fortran/)
- [Fortran-lang](https://fortran-lang.org/)
- [Fortran-lang GitHub](https://github.com/fortran-lang)
## Çalışma Notları Taslağı

Aşağıdaki taslağı kullanarak kendi notlarınızı tutabilirsiniz.

---
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
- Bu konuyla ilgili önemli detaylar.
- Karşılaşılan zorluklar veya kafa karıştırıcı noktalar.
- Gelecekte tekrar gözden geçirilmesi gerekenler.

---

