// class AnimalModel {
//   double health;
//   double happiness;
//   double hunger;

//   AnimalModel({this.health = 1, this.happiness = 1, this.hunger = 1});

//   void updateStatus(String action) {
//     if (action == "feed") {
//       health = (health + 10).clamp(0, 100);
//       happiness = (happiness + 5).clamp(0, 100);
//       hunger = (hunger - 15).clamp(0, 100);
//     } else if (action == "clean") {
//       health = (health + 8).clamp(0, 100);
//       happiness = (happiness + 6).clamp(0, 100);
//     } else if (action == "play") {
//       health = (health + 5).clamp(0, 100);
//       happiness = (happiness + 10).clamp(0, 100);
//       hunger = (hunger + 8).clamp(0, 100);
//     }
//   }
// }
class AnimalModel {
  int? id;
  String name;
  String type;
  double health;
  double happiness;
  double hunger;
  String lastUpdateTime;

  AnimalModel({
    this.id,
    this.name = '',
    this.type = '',
    this.health = 100,
    this.happiness = 100,
    this.hunger = 0,
    this.lastUpdateTime = '',
  });

  // Veritabanı için Map'e dönüştürme
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'health': health,
      'happiness': happiness,
      'hunger': hunger,
      'lastUpdateTime': lastUpdateTime,
    };
  }

  // Veritabanından Map'i modele dönüştürme
  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    return AnimalModel(
      id: map['id'],
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      health: (map['health'] as num).toDouble(),
      happiness: (map['happiness'] as num).toDouble(),
      hunger: (map['hunger'] as num).toDouble(),
      lastUpdateTime: map['lastUpdateTime'] ?? '',
    );
  }

  // Hayvanın durumunu güncelleme (besleme, temizleme, oynama)
  void updateStatus(String action) {
    if (action == "feed") {
      health = (health + 2).clamp(0, 100);
      happiness = (happiness + 2).clamp(0, 100);
      hunger = (hunger - 2).clamp(0, 100);
    } else if (action == "clean") {
      health = (health + 2).clamp(0, 100);
      happiness = (happiness + 2).clamp(0, 100);
    } else if (action == "play") {
      health = (health + 2).clamp(0, 100);
      happiness = (happiness + 2).clamp(0, 100);
      hunger = (hunger + 2).clamp(0, 100);
    }
  }

  // Zaman bazlı parametre güncellemesi
  void updateParametersBasedOnTime(DateTime lastUpdate) {
    DateTime now = DateTime.now();
    int minutesPassed = now.difference(lastUpdate).inMinutes;
    
    // Her dakika için değişim oranları
    double hungerIncreasePerMinute = 0.5; // Açlık artışı
    double healthDecreasePerMinute = 0.2; // Sağlık azalışı
    double happinessDecreasePerMinute = 0.2; // Mutluluk azalışı
    
    // Parametreleri güncelle
    hunger = (hunger + minutesPassed * hungerIncreasePerMinute).clamp(0, 100);
    health = (health - minutesPassed * healthDecreasePerMinute).clamp(0, 100);
    happiness = (happiness - minutesPassed * happinessDecreasePerMinute).clamp(0, 100);
    
    // Son güncelleme zamanını güncelle
    lastUpdateTime = now.toIso8601String();
  }

  // Sağlık bildirimi kontrolü
  bool shouldNotifyHealth() {
    return health < 20;
  }

  // Mutluluk bildirimi kontrolü
  bool shouldNotifyHappiness() {
    return happiness < 20;
  }

  // Açlık bildirimi kontrolü
  bool shouldNotifyHunger() {
    return hunger > 80;
  }
}
