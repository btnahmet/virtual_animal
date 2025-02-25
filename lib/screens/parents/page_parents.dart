// import 'package:flutter/material.dart';

// class PageParents extends StatefulWidget {
//   const PageParents({super.key});

//   @override
//   State<PageParents> createState() => _PageParentsState();
// }

// class _PageParentsState extends State<PageParents> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }
import 'package:flutter/material.dart';

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

    return Scaffold(
      backgroundColor: const Color.fromARGB(190, 252, 249, 249),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: screenHeight * 0.17,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon("assets/images/cat.png"), // Sol ikon
                SizedBox(width: screenWidth * 0.05),
                _buildIcon("assets/images/dog.png"), // Orta ikon
                SizedBox(width: screenWidth * 0.05),
                _buildIcon("assets/images/bird.png"), // Sağ ikon
              ],
            ),
          ),
          // Positioned(
          //   top: screenHeight * 0.15,
          //   child: Image.asset(
          //     'assets/images/cat.png',
          //     width: screenWidth * 0.4,
          //     height: screenWidth * 0.4,
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.65,
              decoration: const BoxDecoration(
                color: Color(0xFFB65C2C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2, vertical: 10),
              child: Column(
                children: [
                  const Text(
                    "Hayvan Takip\nEbeveyn Ekranı",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildButton("İlerlemeyi Görüntüle"),
                  const SizedBox(height: 30),
                  _buildButton("Bildirim Ayarları"),
                  const SizedBox(height: 30),
                  _buildButton("Kullanıcı Yönetimi"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 📌 **Üst Kısımdaki 3 Resmi Oluşturur**
  Widget _buildIcon(String imagePath) {
    return Image.asset(
      imagePath,
      width: 115,
      height: 115,
      fit: BoxFit.contain,
    );
  }

  /// 📌 **Alt Kısımdaki Butonları Oluşturur**
  Widget _buildButton(String text) {
    return SizedBox(
      width: 260,
      child: ElevatedButton(
        onPressed: () {
          print("$text butonuna basıldı!");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFA07A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(vertical: 17),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
