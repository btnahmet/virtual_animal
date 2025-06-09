import 'package:flutter/material.dart';
import 'package:virtual_animal/screens/parents/login_parents.dart';
import 'package:virtual_animal/screens/register.dart';

class KullaniciYonetimi extends StatefulWidget {
  const KullaniciYonetimi({super.key});

  @override
  State<KullaniciYonetimi> createState() => _KullaniciYonetimiState();
}

class _KullaniciYonetimiState extends State<KullaniciYonetimi> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(186, 255, 202, 189),
        appBar: AppBar(
          title: const Text('Kullanıcı Yönetimi',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 237, 125, 65),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Yeni bir çocuk hesabı eklemek ister misiniz?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                _buildButton(
                  'Çocuk Hesabı Ekle',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                  screenWidth,
                  screenHeight,
                ),
                SizedBox(height: screenHeight * 0.03),
                _buildButton(
                  'Çocuk Hesabını Onayla',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginParents()),
                    );
                  },
                  screenWidth,
                  screenHeight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.8,
      height: screenHeight * 0.08,
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
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}