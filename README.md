# Fortran Çalışma Notları
Güncel notlar ve örnekler için lütfen şu adresi ziyaret edin:

[Bu reponun GitHub Pages sayfası](https://onkanat.github.io/fortran/) 

## Site ayarları (GitHub Pages)
- Tema: `jekyll-theme-primer` (GitHub varsayılan tema)
- URL/Baseurl: `https://onkanat.github.io` + `/fortran`
- Varsayılan layout: `default` (sayfa önbilgilerinde `layout: default` kullanılıyor)

## Proje rehberleri
- [Proje Yapısı ve Standartları](./GEMINI.md)
- [Copilot kullanım yönergeleri](./.github/copilot-instructions.md)

## İlgili kaynaklar
- [onkanat.org](https://www.onkanat.org/): FreeCAD, KiCad ve GNU Octave gibi açık kaynak araçlara odaklanan, paylaşarak üretimi teşvik eden bilgi merkezi.
- [Octave Türkçe Dokümantasyon](https://onkanat.github.io/Octave_TR_Doc/): GNU Octave için Türkçe eğitim notları; temel matematik, matris işlemleri, veri/grafik fonksiyonları, sinyal-görüntü işleme ve optimizasyon konularını içerir.

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
## İlgili kaynaklar
- [onkanat.org](https://www.onkanat.org/): FreeCAD, KiCad ve GNU Octave gibi açık kaynak araçlara odaklanan, paylaşarak üretimi teşvik eden bilgi merkezi.
- [Octave Türkçe Dokümantasyon](https://onkanat.github.io/Octave_TR_Doc/): GNU Octave için Türkçe eğitim notları; temel matematik, matris işlemleri, veri/grafik fonksiyonları, sinyal-görüntü işleme ve optimizasyon konularını içerir.
- [Modern Fortran (GitHub)](https://github.com/modern-fortran/)
- [Fortran-lang](https://fortran-lang.org/)
- [Fortran-lang GitHub](https://github.com/fortran-lang)
