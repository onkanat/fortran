# Kesme Formülleri Dokümantasyonu

## Program: cutting_formules_enhanced

Bu Fortran programı, verilen çap (D) ve devir sayısı (n) değerlerine göre kesme hızını (Vc) hesaplar; ayrıca kesme hızı (Vc) ve çap (D) verildiğinde devir sayısını (n) hesaplar.

### Formül
```
Vc = (π × D × n) / 1000
n = (Vc × 1000) / (π × D)
```

Burada:
- D = Çap, milimetre (mm) cinsinden
- n = Devir sayısı, dakika başına devir (rpm) cinsinden
- Vc = Kesme hızı, metre/dakika (m/min) cinsinden

### Program Özellikleri

1. **Çift Yönlü Hesaplamalar**:
   - Çap (D) ve devirden (n) kesme hızını (Vc) hesaplar.
   - Kesme hızı (Vc) ve çaptan (D) devri (n) hesaplar.

2. **Hassas Hesaplama**: Yüksek doğruluk için çift duyarlıklı (kind=8) değişkenler kullanır.

3. **Girdi Doğrulama**: 
   - Tüm girdilerin pozitif değerler olduğunu kontrol eder.
   - Geçersiz girdiler için hata yönetimi sağlar.

4. **Etkileşimli Arayüz**: 
   - Hesaplama türü için menü seçimi sunar.
   - Kullanıcı girdisi için net yönlendirmeler yapar.
   - Birimlerle birlikte düzgün biçimlendirilmiş çıktı verir.

### Nasıl Kullanılır

1. Programı derleyin:
   ```
   gfortran -o cutting_formules_enhanced cutting_formules_enhanced.f90
   ```

2. Programı çalıştırın:
   ```
   ./cutting_formules_enhanced
   ```

3. Hesaplama türünü seçin:
   - Seçim 1: D (mm), n (rpm) → Vc (m/min) 
   - Seçim 2: Vc (m/min), D (mm) → n (rpm)

### Örnek Hesaplamalar

**Örnek 1: Hız Hesaplama**
Eğer bir iş parçasının çapı 50 mm ise ve 1000 rpm ile dönüyorsa:
```
Vc = (3.1415926535897932384626433832795 × 50 × 1000) / 1000
Vc = 157.080 m/min
```

**Örnek 2: Devir (RPM) Hesaplama**
Eğer bir iş parçasının kesme hızı 157.080 m/min ve çapı 50 mm ise:
```
n = (157.080 × 1000) / (3.1415926535897932384626433832795 × 50)
n = 1000.000 rpm
```

### Matematiksel Kavram

Bu hesaplama, kesme hızının (Vc) kesici takımın iş parçası malzemesine göre doğrusal hızını temsil ettiği talaşlı imalat işlemlerinde temeldir. Formül şunlar arasındaki ilişkiyi açıklar:

1. Takım çapı (D): Kesici ucun doğrusal hızını etkiler.
2. Dönme hızı (n): İş parçasının ne kadar hızlı döndüğü.
3. Kesme hızı (Vc): Takımın malzemeye göre efektif hızı.

Paydadaki 1000 çarpanı, milimetreyi metreye çevirir, bu da işleme operasyonlarında doğru birimler için gereklidir.

### Program Yapısı

Geliştirilmiş program şu şekilde yapılandırılmıştır:
1. Kullanıcının hesaplama türünü seçmesi için bir menü sunar.
2. Seçime göre uygun girdileri toplar.
3. Seçilen hesaplamayı gerçekleştirir.
4. Sonuçları uygun birimler ve notlarla görüntüler.
5. Geçersiz girdiler için hata yönetimi içerir.

Bu program, Fortran'ın imalat mühendisliğinde, özellikle CNC işleme ve takım seçimi süreçlerinde pratik bir uygulamasını gösterir.
