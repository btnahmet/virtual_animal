import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/Games/game_home_page.dart';
import 'animal_screen.dart';
import 'animal_model.dart';
import 'package:virtual_animal/screens/Games/game_renk_esleme.dart';

class Cat extends StatelessWidget {
  const Cat({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimalScreen(
      animalName: "Kedi",
      imagePath: "assets/images/cat.png",
      animalModel: AnimalModel(type: "Kedi"),
      onGameNavigate: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameHomePage()),
        );
      },
    );
  }
}

