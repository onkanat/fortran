# Fortran Çalışma Notları

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

İşte basit bir "Merhaba Dünya" programı. Bu kod `main.f90` dosyasında mevcuttur.

```fortran
! main.f90
program hello
  print *, "Hello, World!"
end program hello
```

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

- **[MERGE Fonksiyonu](./demo_merge.f90)**: `demo_merge.f90` dosyası, Fortran'ın güçlü `MERGE` içsel fonksiyonunun skaler ve dizi tabanlı kullanımını gösterir. Bu fonksiyon, bir maskeye dayalı olarak iki değer veya dizi arasından eleman seçimi yapmak için kullanılır. Detaylı açıklaması [demo_merge.md](./demo_merge.md) dosyasında bulunmaktadır.
- **[ABS Fonksiyonu](./demo_abs.f90)**: `demo_abs.f90` dosyası, `ABS` fonksiyonunun tamsayı, gerçek ve karmaşık sayılarla nasıl kullanıldığını gösterir. Detaylı açıklaması [demo_abs.md](./demo_abs.md) dosyasında bulunmaktadır.
- **[Mandelbrot Seti](./Mandelbrot.f90)**: `Mandelbrot.f90` programı, modüler bir yaklaşımla Mandelbrot kümesini hesaplar. Açıklaması ve gerekli yardımcı modüller [Mandelbrot.md](./Mandelbrot.md) dosyasında detaylandırılmıştır.
- **[Sinüs Fonksiyonu Üretimi](./sine.f90)**: `sine.f90` dosyası, `neural-fortran` kütüphanesini kullanarak bir sinir ağının sinüs fonksiyonunu nasıl öğrendiğini gösterir. Detaylı açıklaması [sine.md](./sine.md) dosyasında bulunmaktadır.
- **[Kare Fonksiyonu](./square_function.md)**: `square_function.md` dosyası, Fortran fonksiyonlarının yapısını ve kullanımını gösteren örnek bir kare alma fonksiyonu içerir. Fonksiyonların nasıl tanımlandığı, nasıl çağrıldığı ve örnek bir uygulama ile açıklaması yer almaktadır.
- **[Kesme Formülleri](./cutting_formules.f90)**: `cutting_formules.f90` dosyası, talaşlı imalatta kesme hızı (Vc) hesaplamasını gösterir. Detaylı açıklaması [cutting_formules.md](./cutting_formules.md) dosyasında bulunmaktadır.
- **[Gelişmiş Kesme Formülleri](./cutting_formules_enhanced.f90)**: `cutting_formules_enhanced.f90` dosyası, kesme hızı ve devir sayısı arasında çift yönlü hesaplama yapabilen gelişmiş bir versiyondur. Detaylı açıklaması [cutting_formules_enhanced.md](./cutting_formules_enhanced.md) dosyasında bulunmaktadır.
- **[Fortran Temel Kavramları](./fortran_basic_elements.md)**: `fortran_basic_elements.md` dosyası, Fortran programlama dilinin temel öğelerini ve yapısını açıklayan bir rehberdir. Değişken tanımlamaları, veri tipleri, kontrol yapıları ve temel giriş/çıkış işlemleri gibi konuları kapsar.

- **[Fortran book code:] (https://github.com/modern-fortran/)**
- **[Fortran-lang:] (https://fortran-lang.org/)**
- **[Fortran-lang GitHub:] (https://github.com/fortran-lang)**
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

