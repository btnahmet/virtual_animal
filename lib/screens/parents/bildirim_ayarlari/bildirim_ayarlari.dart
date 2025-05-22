import 'package:flutter/material.dart';

class BildirimAyarlari extends StatefulWidget {
  const BildirimAyarlari({super.key});

  @override
  State<BildirimAyarlari> createState() => _BildirimAyarlariState();
}

class _BildirimAyarlariState extends State<BildirimAyarlari> {
  bool notificationsEnabled = true;

  void _showNotificationAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double buttonWidth = screenWidth * 0.6; // Ekran genişliğinin %80'i
    final double buttonHeight = screenHeight * 0.08; // Ekran yüksekliğinin %8'i
    final double fontSize = screenWidth * 0.06; // Ekran genişliğinin %5'i
    final double spacing = screenHeight * 0.03; // Ekran yüksekliğinin %3'ü

    return Scaffold(
      backgroundColor: const Color.fromARGB(188, 255, 174, 154),
      appBar: AppBar(
        title: Text(
          'Bildirim Ayarları',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.06, // Ekran genişliğinin %6'sı
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    notificationsEnabled = true;
                  });
                  _showNotificationAlert('Bildirimler açıldı');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                ),
                child: Text(
                  'Bildirimleri Aç',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: spacing),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    notificationsEnabled = false;
                  });
                  _showNotificationAlert('Bildirimler kapatıldı');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  ),
                ),
                child: Text(
                  'Bildirimleri Kapat',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
