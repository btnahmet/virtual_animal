import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/parents/bildirim_ayarlari/bildirim_ayarlari.dart';
import 'package:virtual_animal/screens/parents/ilerleme_goruntuleme/hayvan_sec.dart';
import 'package:virtual_animal/screens/parents/kullanici_yonetimi/kullanici_yonetimi.dart';
// İlerleme ekranı import edildi

class PageParents extends StatefulWidget {
  const PageParents({super.key});

  @override
  State<PageParents> createState() => _PageParentsState();
}

class _PageParentsState extends State<PageParents> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    // Ekran boyutuna göre oransal değerler
    final double topPadding = screenHeight * 0.12;
    final double iconSize = screenWidth * 0.3;
    final double iconSpacing = screenWidth * 0.04;
    final double bottomContainerHeight = screenHeight * 0.68;
    final double buttonWidth = screenWidth * 0.8;
    final double buttonHeight = screenHeight * 0.08;
    final double buttonSpacing = screenHeight * 0.04;
    final double titleFontSize = screenWidth * 0.08;
    final double buttonFontSize = screenWidth * 0.055;

    return Scaffold(
      backgroundColor: const Color.fromARGB(188, 255, 174, 154),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: topPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon("assets/images/cat.png", iconSize),
                SizedBox(width: iconSpacing),
                _buildIcon("assets/images/dog.png", iconSize),
                SizedBox(width: iconSpacing),
                _buildIcon("assets/images/bird.png", iconSize),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: bottomContainerHeight,
              decoration: const BoxDecoration(
                color: Color(0xFFB65C2C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1,
                vertical: screenHeight * 0.03,
              ),
              child: Column(
                children: [
                  Text(
                    "Hayvan Takip\nEbeveyn Ekranı",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: buttonSpacing),
                  _buildButton(
                    "İlerlemeyi Görüntüle",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HayvanSec()),
                      );
                    },
                    buttonWidth,
                    buttonHeight,
                    buttonFontSize,
                  ),
                  SizedBox(height: buttonSpacing),
                  _buildButton(
                    "Bildirim Ayarları",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BildirimAyarlari()),
                      );
                    },
                    buttonWidth,
                    buttonHeight,
                    buttonFontSize,
                  ),
                  SizedBox(height: buttonSpacing),
                  _buildButton(
                    "Kullanıcı Yönetimi",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const KullaniciYonetimi()),
                      );
                    },
                    buttonWidth,
                    buttonHeight,
                    buttonFontSize,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 📌 **Üst Kısımdaki 3 Resmi Oluşturur**
  Widget _buildIcon(String imagePath, double size) {
    return Image.asset(
      imagePath,
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }

  /// 📌 **Alt Kısımdaki Butonları Oluşturur**
  Widget _buildButton(String text, VoidCallback onPressed, double width, double height, double fontSize) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFA07A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
