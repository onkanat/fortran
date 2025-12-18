# Pure/Elemental Fonksiyonlar (`pure_elemental_demo`)

Bu örnek, Modern Fortran'da **`pure`** ve **`elemental`** anahtar kelimeleriyle yazılan fonksiyonların dizi üzerinde nasıl doğal şekilde çalıştığını gösterir.

## Amaç

- `pure`: fonksiyonun yan etkisiz olmasını (global state değiştirmemesini) teşvik eder
- `elemental`: fonksiyonun skaler gibi yazılıp diziye uygulandığında eleman-bazlı çalışmasını sağlar

Bu örnekte `clamp(x, lo, hi)` fonksiyonu, bir değeri $[lo, hi]$ aralığına sıkıştırır.

## Derleme ve Çalıştırma

```sh
gfortran pure_elemental_demo.f90 -o pure_elemental_demo
./pure_elemental_demo
```

## Öne Çıkan Noktalar

- `elemental` fonksiyonlar dizilerle çok okunaklı kod yazdırır.
- `pure` + `elemental` kombinasyonu, derleyicinin optimizasyon yapabilmesini de kolaylaştırır.

## Alıştırmalar

1. `clamp` fonksiyonunu `integer` için de çalışacak şekilde generic interface ile genişletin.
2. `elemental` bir `square(x)` fonksiyonu ekleyin ve dizi üzerinde deneyin.
3. `lo > hi` durumunda hata vermek için nasıl bir strateji izlenebileceğini düşünün (not: elemental fonksiyonda hata yönetimi).
