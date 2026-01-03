# Proje Yapısı ve Standartları

Bu dosya, Modern Fortran öğrenme projesinin yapısını, kullanılan standartları ve yeni bir örnek ekleme sürecini belgeler. Tüm kod ve açıklamalar Türkçedir.

## Klasörün Amacı

Bu proje, Modern Fortran dilini öğrenmek için kişisel bir bilgi tabanı olarak tasarlanmıştır. Her bir Fortran özelliği veya konsepti, ayrı bir kod örneği ve açıklayıcı bir Markdown dosyası ile belgelenir. Tüm belgeler Türkçe olarak yazılmıştır.

## Standart Proje Yapısı

Proje aşağıdaki dosya ve klasör yapısını benimser:

- **`index.md`**: Projenin ana giriş noktasıdır. Tüm örneklere ve belgelere buradan ulaşılır.
- **`*.f90` dosyaları**: Fortran kaynak kodunu içerir. Her örnek için ayrı bir `.f90` dosyası bulunur.
- **`*.md` dosyaları**: Fortran kodunu açıklayan Markdown dosyalarıdır. Her `.f90` dosyasına karşılık gelen bir `.md` dosyası bulunur ve kodun ne yaptığını, nasıl derlendiğini ve kullanıldığını Türkçe olarak açıklar.
- **`assets/`**: Resimler gibi statik varlıkların saklandığı klasördür.
- **`runs/`**: Çalıştırma çıktıları veya ek deney kayıtları için kullanılan klasördür (gerektiğinde).

### Güncel içerik başlıkları

`index.md` şu anda aşağıdaki başlıklar altında örnekleri listeler (yeni örnek eklerken uygun bölüme yerleştirin):

- Temel dil özellikleri ve içsel fonksiyonlar (örn. `merge`, `abs`).
- Diziler (tek boyutlu dizi işlemleri, standart sapma programı).
- Metin (string) işleme (karakter/string fonksiyonları ve ayrıştırma).
- Kontrol akışı ve doğrulama (`quadratic`, `grades`, `date_check`).
- Döngüler (`sos_difference`).
- Fonksiyonlar ve prosedürler (pure/elemental dahil).
- Dosya G/Ç (güvenli dosya açma, `file_operations` rehberi).
- P1/P2 modern konular (modüller, `iso_fortran_env`, `do concurrent`, `iso_c_binding`).
- Uygulamalı örnekler (kesme formülleri, sarkaç). 
- Harici kütüphaneler (`neural-fortran` ile `sine`).
- İleri konular taslak (`Mandelbrot`).

## Yeni Bir Örnek Ekleme Süreci

Yeni bir Fortran örneği eklemek için aşağıdaki adımlar izlenir:

1.  **`.f90` Dosyası Oluşturma**
    - Program/modül başına tek dosya olacak şekilde yeni bir `.f90` oluşturun (örn: `yeni_ornek.f90`).
    - `implicit none` ile başlayın, `snake_case` isimlendirme kullanın, gerekiyorsa `real(kind=8)` tercih edin.
    - G/Ç için `print *`/`write(*,*)` ve güvenli dosya açma (`newunit=`, `iostat`, `iomsg`) şablonlarını kullanın.

2.  **`.md` Dosyası Oluşturma**
    - Kodu açıklayan eş bir Markdown dosyası oluşturun (örn: `yeni_ornek.md`).
    - Şu bilgileri ekleyin: amaç, derleme komutu (`gfortran <dosya>.f90 -o <ad>`), çalıştırma komutu ve beklenen çıktı, önemli kod noktaları. Dil Türkçe olmalıdır.

3.  **`index.md` Dosyasını Güncelleme**
    - Yeni `.md` dosyasına bağlantıyı ilgili başlık altında ekleyin (örneğin Dosya G/Ç, Diziler, P1/P2 vb.).
    - Bağlantıya kısa bir açıklama ekleyin; varsa `.f90` dosyasına da parantez içinde link verin.

Örnek ekleme:
```markdown
- [Yeni Örnek](./yeni_ornek.md) (kod: [yeni_ornek.f90](./yeni_ornek.f90)): Bu örnek şunu yapar...
```
