import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:virtual_animal/screens/animals/animal_model.dart';

class AnimalScreen extends StatefulWidget {
  final String animalName;
  final String imagePath;
  final AnimalModel animalModel;
  final VoidCallback onGameNavigate;

  const AnimalScreen({
    super.key,
    required this.animalName,
    required this.imagePath,
    required this.animalModel,
    required this.onGameNavigate,
  });

  @override
  State<AnimalScreen> createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  void updateAnimalStatus(String action) {
    setState(() {
      widget.animalModel.updateStatus(action);
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
              widget.imagePath,
              width: screenWidth * 0.4,
              height: screenWidth * 0.4,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.659,
              decoration: const BoxDecoration(
                color: Color(0xFFB65C2C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 20),
              child: Column(
                children: [
                  Text(
                    widget.animalName,
                    style: const TextStyle(
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
                      _buildActionButton("Besle", () => updateAnimalStatus("feed")),
                      _buildActionButton("Temizle", () => updateAnimalStatus("clean")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton("Oyna", () => updateAnimalStatus("play")),
                      _buildActionButton("Mini Oyun", widget.onGameNavigate),
                    ],
                  ),
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
          maxY: 100,
          barGroups: [
            _buildBarGroup(0, "Sağlık", widget.animalModel.health),
            _buildBarGroup(1, "Mutluluk", widget.animalModel.happiness),
            _buildBarGroup(2, "Açlık", widget.animalModel.hunger),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 10,
                getTitlesWidget: (value, meta) => Text(
                  '${value.toInt()}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
          gridData: const FlGridData(show: false),
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
          width: 18,
          borderRadius: BorderRadius.circular(2),
        ),
      ],
    );
  }

  // Widget _buildActionButton(String text, VoidCallback onPressed) {
  //   return ElevatedButton(
  //     onPressed: onPressed,
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: const Color(0xFFFFA07A),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //     ),
  //     child: Text(
  //       text,
  //       style: const TextStyle(
  //         color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
  //     ),
  //   );
  // }
  Widget _buildActionButton(String text, VoidCallback onPressed) {
  return SizedBox(
    width: 150, // Sabit genişlik (isteğe bağlı değiştirilebilir)
    height: 60, // Sabit yükseklik
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFA07A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        padding: EdgeInsets.zero, // İç dolguyu sıfırladık
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

}
