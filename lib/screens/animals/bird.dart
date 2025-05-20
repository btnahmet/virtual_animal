import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/Games/game_home_page.dart';
import 'animal_screen.dart';
import 'animal_model.dart';

class Bird extends StatelessWidget {
  const Bird({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimalScreen(
      animalName: "Kuş",
      imagePath: "assets/images/bird.png",
      animalModel: AnimalModel(type: "Kuş"),
      onGameNavigate: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameHomePage()),
        );
      },
    );
  }
}

