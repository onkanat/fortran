# Sarkacın Periyodu Hesabı (`pendulum`)

Bu örnek, basit bir fizik formülü kullanarak sarkacın periyodunu (salınım süresi) hesaplar. Kullanıcıdan:

- Sarkacın uzunluğu (cm)
- Yer değiştirme açısı (derece)

alınır ve periyot saniye cinsinden yazdırılır.

## Derleme ve Çalıştırma

```sh
gfortran pendulum.f90 -o pendulum
./pendulum
```

## Beklenen Çıktı

Program, girdilere bağlı olarak şu formata benzer bir çıktı üretir:

- `Sarkacın periyodu (sn) =   1.2345`

## Öne Çıkan Noktalar

- `real(kind=8)` ile hassasiyet artırılır.
- Basit girdi doğrulama yapılır (uzunluk pozitif olmalı).
- Dereceden radyana dönüşüm örneği içerir.

## Alıştırmalar

1. Açı için de doğrulama ekleyin (ör. $0 \le \alpha \le 90$ gibi).
2. Birden fazla test girdisi için döngüyle tekrar çalışacak hale getirin.
3. Uzunluğu metre alan bir seçenek ekleyip birim dönüşümü uygulayın.
