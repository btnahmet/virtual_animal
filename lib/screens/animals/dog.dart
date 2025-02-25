// import 'package:flutter/material.dart';

// class Dog extends StatefulWidget {
//   const Dog({super.key});

//   @override
//   State<Dog> createState() => _DogState();
// }

// class _DogState extends State<Dog> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Grafik için kütüphane ekledik

class Dog extends StatefulWidget {
  const Dog({super.key});

  @override
  State<Dog> createState() => _DogState();
}

class _DogState extends State<Dog> {
  // Örnek sağlık, mutluluk ve açlık değerleri
  double health = 80;
  double happiness = 60;
  double hunger = 40;

  void updateStatus(String action) {
    setState(() {
      if (action == "feed") {
        hunger = (hunger - 10).clamp(0, 100);
        health = (health + 5).clamp(0, 100);
      } else if (action == "clean") {
        health = (health + 10).clamp(0, 100);
        happiness = (happiness + 5).clamp(0, 100);
      } else if (action == "play") {
        happiness = (happiness + 10).clamp(0, 100);
        hunger = (hunger + 5).clamp(0, 100);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(190, 252, 249, 249),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: screenHeight * 0.1,
            child: Image.asset(
              'assets/images/dog.png',
              width: screenWidth * 0.35,
              height: screenWidth * 0.35,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.6,
              decoration: BoxDecoration(
                color: const Color(0xFFB65C2C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
              child: Column(
                children: [
                  const Text(
                    "Hayvan Takip",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildChart(screenWidth),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton("Hayvanı Besle", () => updateStatus("feed")),
                      _buildActionButton("Hayvanı Temizle", () => updateStatus("clean")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildActionButton("Hayvan ile Oyun Oyna", () => updateStatus("play")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(double screenWidth) {
    return SizedBox(
      height: 150,
      width: screenWidth * 0.9,
      child: BarChart(
        BarChartData(
          barGroups: [
            _buildBarGroup(0, "Sağlık", health),
            _buildBarGroup(1, "Mutluluk", happiness),
            _buildBarGroup(2, "Açlık", hunger),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return const Text("Sağlık", style: TextStyle(color: Colors.white));
                    case 1:
                      return const Text("Mutluluk", style: TextStyle(color: Colors.white));
                    case 2:
                      return const Text("Açlık", style: TextStyle(color: Colors.white));
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, String label, double value) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: Colors.orangeAccent,
          width: 15,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFA07A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
