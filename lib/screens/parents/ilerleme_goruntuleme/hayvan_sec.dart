// import 'package:flutter/material.dart';
// import 'package:virtual_animal/screens/animals/bird.dart';
// import 'package:virtual_animal/screens/animals/cat.dart';
// import 'package:virtual_animal/screens/animals/dog.dart';
// import 'package:virtual_animal/screens/parents/ilerleme_goruntuleme/ilerleme_goruntuleme_bird.dart';
// import 'package:virtual_animal/screens/parents/ilerleme_goruntuleme/ilerleme_goruntuleme_cat.dart';
// import 'package:virtual_animal/screens/parents/ilerleme_goruntuleme/ilerleme_goruntuleme_dog.dart';
// import 'package:virtual_animal/screens/parents/login_parents.dart';
// import 'package:virtual_animal/screens/parents/page_parents.dart';

// class HayvanSec extends StatefulWidget {
//   const HayvanSec({super.key});

//   @override
//   State<HayvanSec> createState() => _HayvanSecState();
// }

// class _HayvanSecState extends State<HayvanSec> {
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(''),
//         backgroundColor:
//             const Color.fromARGB(255, 241, 153, 105), // Arka plan rengi
//       ),
//       backgroundColor:
//           const Color.fromARGB(255, 241, 153, 105), // Arka plan rengi
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           _buildTitle(screenWidth), // "Dostunu Seç" başlığı
//           const SizedBox(height: 40),
//           _buildFriendRow("assets/images/cat.png", "Kedi", screenWidth),
//           const SizedBox(height: 20),
//           _buildFriendRow("assets/images/bird.png", "Kuş", screenWidth),
//           const SizedBox(height: 20),
//           _buildFriendRow("assets/images/dog.png", "Köpek", screenWidth),
//           const SizedBox(height: 20), // Alt boşluk bırakır
//         ],
//       ),
//     );
//   }

//   Widget _buildTitle(double screenWidth) {
//     return Container(
//       width: screenWidth * 0.7,
//       padding: const EdgeInsets.symmetric(vertical: 0),
//       decoration: BoxDecoration(
//         // color: const Color(0xFFFFA07A), // Açık turuncu
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: const Center(
//         child: Text(
//           "Dostunu Seç",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 35,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFriendRow(String imagePath, String name, double screenWidth) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Image.asset(
//           imagePath,
//           width: screenWidth * 0.34,
//           height: screenWidth * 0.34,
//           fit: BoxFit.contain,
//         ),
//         _buildSelectButton(name, screenWidth),
//       ],
//     );
//   }

//   Widget _buildSelectButton(String text, double screenWidth) {
//     return SizedBox(
//       width: screenWidth * 0.25,
//       child: ElevatedButton(
//         onPressed: () {
//           Widget targetPage;
//           switch (text) {
//             case "Kedi":
//               targetPage = const IlerlemeGoruntulemeCat();
//               break;
//             case "Kuş":
//               targetPage = const IlerlemeGoruntulemeBird();
//               break;
//             case "Köpek":
//               targetPage = const IlerlemeGoruntulemeDog();
//               break;
//             default:
//               targetPage = const HayvanSec();
//           }

//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => targetPage),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFFFA07A), // Açık turuncu buton rengi
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 10),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/parents/ilerleme_goruntuleme/ilerleme_goruntuleme_bird.dart';
import 'package:virtual_animal/screens/parents/ilerleme_goruntuleme/ilerleme_goruntuleme_cat.dart';
import 'package:virtual_animal/screens/parents/ilerleme_goruntuleme/ilerleme_goruntuleme_dog.dart';

class HayvanSec extends StatefulWidget {
  const HayvanSec({super.key});

  @override
  State<HayvanSec> createState() => _HayvanSecState();
}

class _HayvanSecState extends State<HayvanSec> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 241, 153, 105), // Arka plan rengi
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.13), // Sayfanın %13'ü kadar boşluk
          _buildTitle(screenWidth), // "Dostunu Seç" başlığı
          const SizedBox(height: 40),
          _buildFriendRow("assets/images/cat.png", "Kedi", screenWidth),
          const SizedBox(height: 20),
          _buildFriendRow("assets/images/bird.png", "Kuş", screenWidth),
          const SizedBox(height: 20),
          _buildFriendRow("assets/images/dog.png", "Köpek", screenWidth),
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
          width: screenWidth * 0.34,
          height: screenWidth * 0.34,
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
              targetPage = const IlerlemeGoruntulemeCat();
              break;
            case "Kuş":
              targetPage = const IlerlemeGoruntulemeBird();
              break;
            case "Köpek":
              targetPage = const IlerlemeGoruntulemeDog();
              break;
            default:
              targetPage = const HayvanSec();
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
