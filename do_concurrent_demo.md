# `do concurrent` ile Bağımsız Döngüler (`do_concurrent_demo`)

Bu örnek, `do concurrent` kullanarak bir döngünün iterasyonlarının **birbirinden bağımsız** olduğunu ifade etmeyi gösterir.

## Amaç

- `do concurrent` söz dizimini öğrenmek
- Yan etkisiz (pure) bir fonksiyonu dizi üzerinde çalıştırmak
- “Gerçekçi ama basit” bir veri dönüşümünü (signal/feature hesaplama gibi) örneklemek

## Derleme ve Çalıştırma

```sh
gfortran do_concurrent_demo.f90 -o do_concurrent_demo
./do_concurrent_demo
```

## Öne Çıkan Noktalar

- `do concurrent` *paralel çalışmayı garanti etmez*; derleyiciye "paralelleştirilebilir" niyeti verir.
- İterasyonlar arası bağımlılık olmaması çok önemlidir.
- Dizi istatistikleri (`minval`, `maxval`, `sum`) ayrı adımda yapılmıştır.

## Alıştırmalar

1. `n` değerini komut satırı argümanından alın.
2. Fonksiyonu `elemental` yapıp doğrudan `y = f(x)` şeklinde deneyin.
3. `system_clock` ile süre ölçümü ekleyin (ölçüm hataları hakkında kısa not yazın).
