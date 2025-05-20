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
    this.health = 1,
    this.happiness = 1,
    this.hunger = 1,
    this.lastUpdateTime = '',
  });

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
