import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/parents/ilerleme_goruntuleme/model_class.dart';

class ProgressScreen extends StatelessWidget {
  final ProgressModel progress;
  final String animalImagePath;

  const ProgressScreen({
    super.key,
    required this.progress,
    required this.animalImagePath,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(title: Text("Progress Screen"),),
      backgroundColor: const Color.fromARGB(190, 252, 249, 249),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: screenHeight * 0.13,
            child: Image.asset(
              animalImagePath, // Dinamik olarak hayvanın resmini kullan
              width: screenWidth * 0.45,
              height: screenWidth * 0.45,
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
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, 
                vertical: 20,
              ),
              child: SingleChildScrollView(
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
                    _buildProgressRow("Sağlık", progress.health, Colors.green, screenWidth),
                    const SizedBox(height: 20),
                    _buildProgressRow("Mutluluk", progress.happiness, Colors.blue, screenWidth),
                    const SizedBox(height: 20),
                    _buildProgressRow("Açlık", progress.hunger, Colors.red, screenWidth),
                  ],
                ),
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
