# Komut Satırı Argümanları (`command_line_args_demo`)

Bu örnek, `command_argument_count` ve `get_command_argument` kullanarak programı komut satırından parametreli çalıştırmayı gösterir.

## Amaç

- `./program 20` gibi bir kullanım ile `N` değerini argümandan okumak
- `random_number` ile `N` adet rastgele sayı üretip ortalama almak

## Derleme ve Çalıştırma

```sh
gfortran command_line_args_demo.f90 -o command_line_args_demo
./command_line_args_demo
./command_line_args_demo 20
```

## Öne Çıkan Noktalar

- Argüman okuma sırasında `read(arg,*, iostat=..., iomsg=...)` ile hata yakalanır.
- `random_seed()` çağrısı seed'i basitçe başlatır.

## Alıştırmalar

1. İkinci bir argüman ile seed değeri alıp deterministik sonuç üretin.
2. Üretilen sayıları dosyaya yazıp (`open(newunit=...)`) tekrar okuyun.
