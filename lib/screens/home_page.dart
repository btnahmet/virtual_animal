import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/animals/bird.dart';
import 'package:virtual_animal/screens/animals/cat.dart';
import 'package:virtual_animal/screens/animals/dog.dart';

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
        backgroundColor: const Color(0xFFB65C2C), // AppBar rengi
      ),
      backgroundColor: const Color(0xFFB65C2C), // Arka plan rengi
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.00),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildTitle(screenWidth), // "Dostunu Seç" başlığı
            const SizedBox(height: 40),
            _buildFriendRow("assets/images/cat.png", "Kedi", screenWidth),
            const SizedBox(height: 20),
            _buildFriendRow("assets/images/bird.png", "Kuş", screenWidth),
            const SizedBox(height: 20),
            _buildFriendRow("assets/images/dog.png", "Köpek", screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(double screenWidth) {
    return Container(
      width: screenWidth * 0.7,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFA07A), // Açık turuncu
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Text(
          "Dostunu Seç",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
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

  // Widget _buildSelectButton(String text, double screenWidth) {
  //   return SizedBox(
  //     width: screenWidth * 0.25,
  //     child: ElevatedButton(
  //       onPressed: () {
  //         // Burada butona basınca ne olacağını belirleyebilirsin
  //         print("$text butonuna basıldı!");
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color(0xFFFFA07A), // Açık turuncu buton rengi
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         padding: const EdgeInsets.symmetric(vertical: 10),
  //       ),
  //       child: Text(
  //         text,
  //         style: const TextStyle(
  //           color: Colors.black,
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }
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
            targetPage = const HomePage(); // Eğer bir hata olursa ana sayfaya yönlendir
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

}
