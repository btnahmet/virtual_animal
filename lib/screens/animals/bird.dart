// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:virtual_animal/screens/Games/game_renk_esleme.dart'; // Grafik için kütüphane ekledik

// class Bird extends StatefulWidget {
//   const Bird({super.key});

//   @override
//   State<Bird> createState() => _BirdState();
// }

// class _BirdState extends State<Bird> {
//   // Örnek sağlık, mutluluk ve açlık değerleri
//   double health = 0;
//   double happiness = 0;
//   double hunger = 0;

//   void updateStatus(String action) {
//     setState(() {
//       if (action == "feed") {
//         health = (health + 10).clamp(0, 100);
//         happiness = (happiness + 5).clamp(0, 100);
//         hunger = (hunger - 15).clamp(0, 100);
//       } else if (action == "clean") {
//         health = (health + 8).clamp(0, 100);
//         happiness = (happiness + 6).clamp(0, 100);
//       } else if (action == "play") {
//         health = (health + 5).clamp(0, 100);
//         happiness = (happiness + 10).clamp(0, 100);
//         hunger = (hunger + 8).clamp(0, 100);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(190, 252, 249, 249),
//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Positioned(
//             top: screenHeight * 0.1,
//             child: Image.asset(
//               'assets/images/bird.png',
//               width: screenWidth * 0.4,
//               height: screenWidth * 0.4,
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: screenHeight * 0.659,
//               decoration: const BoxDecoration(
//                 color: Color(0xFFB65C2C),
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//               ),
//               padding: EdgeInsets.symmetric(
//                   horizontal: screenWidth * 0.05, vertical: 20),
//               child: Column(
//                 children: [
//                   const Text(
//                     "Hayvan Takip",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   _buildChart(screenWidth),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildActionButton(
//                           "Hayvanı Besle", () => updateStatus("feed")),
//                       _buildActionButton(
//                           "Hayvanı Temizle", () => updateStatus("clean")),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildActionButton(
//                           "Oyun Oyna", () => updateStatus("play")),
//                       _buildActionButton(
//                           "Mini Oyun", () => _navigateToGame(context)),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildChart(double screenWidth) {
//     return SizedBox(
//       height: 150,
//       width: screenWidth * 0.9,
//       child: BarChart(
//         BarChartData(
//           maxY: 100, // Y ekseni maksimum 100
//           barGroups: [
//             _buildBarGroup(0, "Sağlık", health),
//             _buildBarGroup(1, "Mutluluk", happiness),
//             _buildBarGroup(2, "Açlık", hunger),
//           ],
//           titlesData: FlTitlesData(
//             // SOL Y EKSENİ (YÜZDELER)
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 interval: 10,
//                 getTitlesWidget: (value, meta) => Text(
//                   '${value.toInt()}',
//                   style: const TextStyle(color: Colors.white, fontSize: 12),
//                 ),
//               ),
//             ),
//             // SAĞ, ÜST VE ALT EKSENLERİ KAPAT
//             rightTitles:
//                 const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             topTitles:
//                 const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//             // ALT X EKSENİ (SAĞLIK/MUTLULUK/AÇLIK)
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   switch (value.toInt()) {
//                     case 0:
//                       return const Text("Sağlık",
//                           style: TextStyle(color: Colors.white));
//                     case 1:
//                       return const Text("Mutluluk",
//                           style: TextStyle(color: Colors.white));
//                     case 2:
//                       return const Text("Açlık",
//                           style: TextStyle(color: Colors.white));
//                     default:
//                       return Container();
//                   }
//                 },
//               ),
//             ),
//           ),
//           borderData: FlBorderData(show: false),
//           gridData: const FlGridData(show: false),
//         ),
//       ),
//     );
//   }

//   BarChartGroupData _buildBarGroup(int x, String label, double value) {
//     return BarChartGroupData(
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: value,
//           color: Colors.orangeAccent,
//           width: 15,
//           borderRadius: BorderRadius.circular(5),
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton(String text, VoidCallback onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFFFFA07A),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(
//             color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   void _navigateToGame(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => GameRenkEsleme()),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/Games/game_home_page.dart';
import 'animal_screen.dart';
import 'animal_model.dart';
import 'package:virtual_animal/screens/Games/game_renk_esleme.dart';

class Bird extends StatelessWidget {
  const Bird({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimalScreen(
      animalName: "Kuş",
      imagePath: "assets/images/bird.png",
      animalModel: AnimalModel(),
      onGameNavigate: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameHomePage()),
        );
      },
    );
  }
}

