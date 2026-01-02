# Case Converter Programı
Bu örnek, kullanıcıdan alınan en fazla 80 karakterlik dizgedeki küçük harfleri büyük harfe çevirir. Rakamlar, boşluklar ve noktalama işaretleri olduğu gibi kalır.

## Derleme ve Çalıştırma
```sh
gfortran case_converter.f90 -o case_converter
./case_converter
```

## Örnek Çalışma
Girdi ve beklenen çıktı:
```
Case Conversion Example
Enter String (80 char max): Hello World!?
-------------------------------------
Final String:
HELLO WORLD!?
```

## Açıklamalar
- `character(len=80)` sabit uzunluk, 80 karakter sınırı ile metni okur.
- `len_trim` sondaki boşlukları atarak gerçek uzunluğu bulur.
- `iachar` ve `achar` ile ASCII kodu üzerinden dönüşüm yapılır. `ascii_delta = iachar('a') - iachar('A')` sabiti küçük/büyük harf farkını temsil eder.
- Döngü yalnızca `'a'`–`'z'` aralığındaki karakterleri değiştirir; diğerleri korunur.
