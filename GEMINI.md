# Proje Yapısı ve Standartları

Bu dosya, Modern Fortran öğrenme projesinin yapısını, kullanılan standartları ve yeni bir örnek ekleme sürecini belgeler.

## Klasörün Amacı

Bu proje, Modern Fortran dilini öğrenmek için kişisel bir bilgi tabanı olarak tasarlanmıştır. Her bir Fortran özelliği veya konsepti, ayrı bir kod örneği ve açıklayıcı bir Markdown dosyası ile belgelenir. Tüm belgeler Türkçe olarak yazılmıştır.

## Standart Proje Yapısı

Proje aşağıdaki dosya ve klasör yapısını benimser:

- **`index.md`**: Projenin ana giriş noktasıdır. Tüm örneklere ve belgelere buradan ulaşılır.
- **`*.f90` dosyaları**: Fortran kaynak kodunu içerir. Her örnek için ayrı bir `.f90` dosyası bulunur.
- **`*.md` dosyaları**: Fortran kodunu açıklayan Markdown dosyalarıdır. Her `.f90` dosyasına karşılık gelen bir `.md` dosyası bulunur ve kodun ne yaptığını, nasıl derlendiğini ve kullanıldığını Türkçe olarak açıklar.
- **`assets/`**: Resimler gibi statik varlıkların saklandığı klasördür.

## Yeni Bir Örnek Ekleme Süreci

Yeni bir Fortran örneği eklemek için aşağıdaki adımlar izlenir:

1.  **`.f90` Dosyası Oluşturma**:
    - Örnek kodu içeren yeni bir `.f90` dosyası oluşturulur (örn: `yeni_ornek.f90`).
    - Kod, projenin genel stil ve formatlama kurallarına uygun olmalıdır.

2.  **`.md` Dosyası Oluşturma**:
    - Kodu açıklayan bir Markdown dosyası oluşturulur (örn: `yeni_ornek.md`).
    - Bu dosya en az şu bilgileri içermelidir:
        - Kodun amacı ve ne yaptığı.
        - Kodun nasıl derleneceği (gerekli `gfortran` komutları).
        - Kodun nasıl çalıştırılacağı ve beklenen çıktı.
        - Kod içindeki önemli bölümlerin açıklamaları.

3.  **`index.md` Dosyasını Güncelleme**:
    - Oluşturulan yeni örneğin `.md` dosyasına bir bağlantı eklenir.
    - Bu bağlantı, `index.md` dosyasındaki "Örnekler" başlığı altına yeni bir madde olarak eklenmelidir.

    Örnek ekleme:
    ```markdown
    - [Yeni Örnek](./yeni_ornek.md): Bu örnek şunu yapar...
    ```
