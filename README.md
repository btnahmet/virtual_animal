# 🐾 Virtual Animal

**Virtual Animal**, Flutter ile geliştirilmiş, sanal bir canlı bakımı deneyimi sunan etkileşimli ve eğlenceli bir mobil uygulamadır. Kullanıcılar sanal hayvanlarını besleyebilir, mutlu edebilir, oyunlar oynayabilir ve gelişimlerini takip edebilir.

## 🚀 Özellikler

- **Hayvan seçimi**: Kullanıcı birden fazla sanal hayvan türünden seçim yapabilir.
- **Besleme & bakım**: Yem, su ve oyuncak temelli günlük ihtiyaçları karşılanabilir.
- **Mutluluk ve sağlık göstergeleri**: Hayvanın ruh ve beden sağlığı izlenebilir.
- **Mini oyunlar**: Enerji ve mutluluğu artıran, kısa ve eğlenceli oyunlar.
- **Veri kaydı**: SQLite/Shared Preferences tabanlı bakım geçmişi saklanabilir.
- **Tema ve ses efekti desteği**: Renkli tema seçenekleri ve etkileşimli ses efektleri.
- Platform bağımsız: Android & iOS

## 📷 Ekran Görüntüleri

![Ekran görüntüsü 2025-06-21 150940](https://github.com/user-attachments/assets/f725b3a2-da3e-43a8-8dd9-4310ddf7d99e)

![Ekran görüntüsü 2025-06-21 150910](https://github.com/user-attachments/assets/07ca252e-43fb-417b-959b-28b0af4ee835)

![Ekran görüntüsü 2025-06-21 150902](https://github.com/user-attachments/assets/10e3c0a6-f856-4c4e-a662-8f93e386603c)

![Ekran görüntüsü 2025-06-21 150850](https://github.com/user-attachments/assets/f61e4cde-bd13-432c-82ef-8a6251d0f819)

![Ekran görüntüsü 2025-06-21 150838](https://github.com/user-attachments/assets/57557d38-edb6-4c36-a13d-40b3ecd9d5be)

![Ekran görüntüsü 2025-06-21 150735](https://github.com/user-attachments/assets/9f4eb9b0-af0a-4a37-ac90-3af4a1c4c6bb)

![Ekran görüntüsü 2025-06-21 150708](https://github.com/user-attachments/assets/c5dc8993-a5c6-4cf6-9c39-414920885147)






## 🛠️ Kurulum & Çalıştırma

```bash
git clone https://github.com/btnahmet/virtual_animal.git
cd virtual_animal
flutter pub get
flutter run

📂 Proje Yapısı
virtual_animal/
├── lib/
│   ├── main.dart             # Uygulama başlangıcı
│   ├── screens/              # Farklı sayfalar (anasayfa, bakım, oyun)
│   ├── widgets/              # Tekrarlanabilir özel bileşenler
│   └── models/               # Hayvan, sağlık, oyun skorları modelleri
├── assets/
│   ├── images/               # Hayvan görselleri
│   └── sounds/               # Ses efektleri
├── database_helper.dart     # Yerel veri saklama sınıfı
├── pubspec.yaml             # Bağımlılıklar ve varlık tanımları
└── test/                    # Birim testler (varsa)

💡 Kullanılan Teknolojiler
* Flutter

* Dart

* Yerel veri saklama: SQLite / Shared Preferences


* Responsive tasarım

🎯 Hedef Kullanıcılar
* Sanal hayvan bakımı seven çocuklar ve yetişkinler

* Flutter öğrenen geliştiriciler için referans bir proje
