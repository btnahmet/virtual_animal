import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/animals/bird.dart';
import 'package:virtual_animal/screens/animals/cat.dart';
import 'package:virtual_animal/screens/animals/dog.dart';
import 'package:virtual_animal/screens/Games/game_renk_esleme.dart';
import 'package:virtual_animal/screens/parents/login_parents.dart';
import 'package:virtual_animal/screens/parents/page_parents.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      backgroundColor: const Color.fromARGB(255, 241, 153, 105), // Arka plan rengi
      ),
      backgroundColor: const Color.fromARGB(255, 241, 153, 105), // Arka plan rengi
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTitle(screenWidth), // "Dostunu Seç" başlığı
          const SizedBox(height: 40),
          _buildFriendRow("assets/images/cat.png", "Kedi", screenWidth),
          const SizedBox(height: 20),
          _buildFriendRow("assets/images/bird.png", "Kuş", screenWidth),
          const SizedBox(height: 20),
          _buildFriendRow("assets/images/dog.png", "Köpek", screenWidth),
          const Spacer(), // Sayfanın altına butonu yerleştirmek için boşluk bırakır
          _buildBottomButton(screenWidth), // Yeni eklenen buton
          const SizedBox(height: 20), // Alt boşluk bırakır
        ],
      ),
    );
  }

  Widget _buildTitle(double screenWidth) {
    return Container(
      width: screenWidth * 0.7,
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        // color: const Color(0xFFFFA07A), // Açık turuncu
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Text(
          "Dostunu Seç",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFriendRow(String imagePath, String name, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          imagePath,
          width: screenWidth * 0.3,
          height: screenWidth * 0.3,
          fit: BoxFit.contain,
        ),
        _buildSelectButton(name, screenWidth),
      ],
    );
  }

  Widget _buildSelectButton(String text, double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.25,
      child: ElevatedButton(
        onPressed: () {
          Widget targetPage;
          switch (text) {
            case "Kedi":
              targetPage = const Cat();
              break;
            case "Kuş":
              targetPage = const Bird();
              break;
            case "Köpek":
              targetPage = const Dog();
              break;
            default:
              targetPage = const HomePage();
          }

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFA07A), // Açık turuncu buton rengi
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// 📌 **Eklendi:** En alta sabitlenen buton
  Widget _buildBottomButton(double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.5, // Buton genişliği
      child: ElevatedButton(
        onPressed: () {
          print("Ana Sayfaya Dön");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  const PageParents()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 255, 160, 122), // AppBar rengi
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: const Text(
          "Ebeveyn Girişi",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), // Yazı rengi
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
