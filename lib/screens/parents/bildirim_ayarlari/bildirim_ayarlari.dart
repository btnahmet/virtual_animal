import 'package:flutter/material.dart';

class BildirimAyarlari extends StatefulWidget {
  const BildirimAyarlari({super.key});

  @override
  State<BildirimAyarlari> createState() => _BildirimAyarlariState();
}

class _BildirimAyarlariState extends State<BildirimAyarlari> {
  bool notificationsEnabled = false;

  void _showNotificationAlert(String message, bool isEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isEnabled ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Ekran boyutuna göre oransal değerler
    final double buttonWidth = screenWidth * 0.8;
    final double buttonHeight = screenHeight * 0.08;
    final double buttonSpacing = screenHeight * 0.04;
    final double buttonFontSize = screenWidth * 0.055;
    final double titleFontSize = screenWidth * 0.08;

    return Scaffold(
      backgroundColor: const Color.fromARGB(188, 255, 174, 154),
      appBar: AppBar(
        title: Text(
          'Bildirim Ayarları',
          style: TextStyle(
            color: Colors.white,
            fontSize: titleFontSize,
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
                  _showNotificationAlert('Bildirimler açıldı', true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Bildirimleri Aç',
                  style: TextStyle(
                    fontSize: buttonFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: buttonSpacing),
            SizedBox(
              width: buttonWidth,
              height: buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    notificationsEnabled = false;
                  });
                  _showNotificationAlert('Bildirimler kapatıldı', false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Bildirimleri Kapat',
                  style: TextStyle(
                    fontSize: buttonFontSize,
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
