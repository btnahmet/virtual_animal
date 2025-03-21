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
  double health;
  double happiness;
  double hunger;

  AnimalModel({
    this.id,
    this.health = 1,
    this.happiness = 1,
    this.hunger = 1,
  });

  // AnimalModel'i Map'e dönüştürme (Veritabanına eklemek için)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'health': health,
      'happiness': happiness,
      'hunger': hunger,
    };
  }

  // Map'ten AnimalModel oluşturma (Veritabanından okuma için)
  factory AnimalModel.fromMap(Map<String, dynamic> map) {
    return AnimalModel(
      id: map['id'],
      health: map['health'],
      happiness: map['happiness'],
      hunger: map['hunger'],
    );
  }

  // Durumu güncelleme
  void updateStatus(String action) {
    if (action == "feed") {
      health = (health + 10).clamp(0, 100);
      happiness = (happiness + 5).clamp(0, 100);
      hunger = (hunger - 15).clamp(0, 100);
    } else if (action == "clean") {
      health = (health + 8).clamp(0, 100);
      happiness = (happiness + 6).clamp(0, 100);
    } else if (action == "play") {
      health = (health + 5).clamp(0, 100);
      happiness = (happiness + 10).clamp(0, 100);
      hunger = (hunger + 8).clamp(0, 100);
    }
  }
}
