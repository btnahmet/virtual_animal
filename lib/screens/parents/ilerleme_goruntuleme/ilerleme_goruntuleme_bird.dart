import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class IlerlemeGoruntulemeBird extends StatefulWidget {
  const IlerlemeGoruntulemeBird({super.key});

  @override
  State<IlerlemeGoruntulemeBird> createState() => _IlerlemeGoruntulemeBirdState();
}

class _IlerlemeGoruntulemeBirdState extends State<IlerlemeGoruntulemeBird> {
  double healthAvg = 75; // Sağlık ortalaması
  double happinessAvg = 60; // Mutluluk ortalaması
  double hungerAvg = 40; // Açlık ortalaması

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
            top: screenHeight * 0.11,
            child: Image.asset(
              'assets/images/bird.png',
              width: screenWidth * 0.6,
              height: screenWidth * 0.6,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.6,
              decoration: const BoxDecoration(
                color: Color(0xFFB65C2C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
              child: Column(
                children: [
                  const Text(
                    "Hayvan Bakım\nİlerlemesi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildProgressRow("Sağlık", healthAvg, Colors.green, screenWidth),
                  const SizedBox(height: 20),
                  _buildProgressRow("Mutluluk", happinessAvg, Colors.blue, screenWidth),
                  const SizedBox(height: 20),
                  _buildProgressRow("Açlık", hungerAvg, Colors.red, screenWidth),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 📌 **Grafik Alanı: Başlık + Yatay Grafik**
  Widget _buildProgressRow(String title, double value, Color color, double screenWidth) {
    return Row(
      children: [
        SizedBox(
          width: screenWidth * 0.3, // Başlık için ayrılan alan (1/3)
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: screenWidth * 0.6, // Grafik için ayrılan alan (2/3)
          height: 20,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: screenWidth * 0.6,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: (screenWidth * 0.6) * (value / 100),
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
