import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/Games/game_home_page.dart';
import 'animal_screen.dart';
import 'animal_model.dart';

class Dog extends StatelessWidget {
  const Dog({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimalScreen(
      animalName: "Köpek",
      imagePath: "assets/images/dog.png",
      animalModel: AnimalModel(type: "Köpek"),
      onGameNavigate: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameHomePage()),
        );
      },
    );
  }
}
