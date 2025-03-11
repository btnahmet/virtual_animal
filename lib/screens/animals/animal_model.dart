class AnimalModel {
  double health;
  double happiness;
  double hunger;

  AnimalModel({this.health = 1, this.happiness = 1, this.hunger = 1});

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
