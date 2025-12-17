# Kesme Formülleri Dokümantasyonu

## Program: cutting_formules

Bu Fortran programı, verilen çap (D) ve devir sayısı (n) değerlerine göre kesme hızını (Vc) hesaplar.

### Formül
```
Vc = (π × D × n) / 1000
```

Burada:
- D = Çap, milimetre (mm) cinsinden
- n = Devir sayısı, dakika başına devir (rpm) cinsinden
- Vc = Kesme hızı, metre/dakika (m/min) cinsinden

### Program Özellikleri

1. **Hassas Hesaplama**: Yüksek doğruluk için çift duyarlıklı (kind=8) değişkenler kullanır.
2. **Girdi Doğrulama**: 
   - Çapın (D) pozitif olduğunu kontrol eder.
   - Devir sayısının (n) pozitif olduğunu kontrol eder.
3. **Hata Yönetimi**: Geçersiz girdi tespit edilirse programı hata kodu 1 ile durdurur.
4. **Net Çıktı**: Hesaplanan kesme hızını m/min cinsinden görüntüler.

### Nasıl Kullanılır
1. Programı derleyin:
   ```
   gfortran -o cutting_formules cutting_formules.f90
   ```
2. Programı çalıştırın:
   ```
   ./cutting_formules
   ```
3. İstendiğinde çapı (D) milimetre cinsinden girin.
4. İstendiğinde devir sayısını (n) rpm cinsinden girin.

### Örnek Hesaplama
Eğer bir iş parçasının çapı 50 mm ise ve 1000 rpm ile dönüyorsa:
```
Vc = (3.1415926535897932384626433832795 × 50 × 1000) / 1000
Vc = 157.080 m/min
```

### Matematiksel Kavram
Bu hesaplama, kesme hızının (Vc) kesici takımın iş parçası malzemesine göre doğrusal hızını temsil ettiği talaşlı imalat işlemlerinde temeldir. Formül, işleme operasyonlarında takım çapı, dönme hızı ve kesme hızı arasındaki ilişkiyi açıklar.

Paydadaki 1000 çarpanı, milimetreyi metreye çevirir (1000 mm = 1 m), bu da işleme hesaplamalarında doğru birimler için gereklidir.

Bu program, Fortran'ın imalat mühendisliğinde, özellikle CNC işleme ve takım seçimi süreçlerinde pratik bir uygulamasını gösterir.
