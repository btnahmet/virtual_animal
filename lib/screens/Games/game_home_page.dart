import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/Games/balloon_game.dart';
import 'package:virtual_animal/screens/Games/game_renk_esleme.dart';
import 'package:virtual_animal/screens/Games/hafiza_oyunu.dart';

class GameHomePage extends StatelessWidget {
  const GameHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Text("OYUNLAR",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 255, 123, 0)
        ),
      backgroundColor: const Color.fromARGB(255, 241, 153, 105), // Arka plan rengi
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildGameOption(
                context,
                "Balon Patlatma Oyunu",
                "assets/images/balon_patlatma.jpeg",
                const BalloonGame(),
              ),
              const SizedBox(height: 50),
              _buildGameOption(
                context,
                "Renk Eşleme Oyunu",
                "assets/images/renk_eslestirme.jpeg",
                const GameRenkEsleme(),
              ),
              const SizedBox(height: 50),
              _buildGameOption(
                context,
                "Hafıza Oyunu",
                "assets/images/hafiza_oyunu.jpeg", // Boş bir placeholder image
                const MemoryGameScreen(), // Henüz yönlendirilecek oyun yok
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📌 **Oyun Seçeneklerini Oluşturan Widget**
  Widget _buildGameOption(BuildContext context, String title, String imagePath,
      Widget? gameScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          imagePath,
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: gameScreen != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => gameScreen),
                    );
                  }
                : null, // Henüz oyun yoksa buton devre dışı
            style: ElevatedButton.styleFrom(
              backgroundColor: gameScreen != null ? Color.fromARGB(255, 255, 123, 0) : Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
