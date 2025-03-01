// // import 'package:flutter/material.dart';

// // class Game extends StatefulWidget {
// //   const Game({super.key});

// //   @override
// //   State<Game> createState() => _GameState();
// // }

// // class _GameState extends State<Game> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container();
// //   }
// // }
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(Game());
// }

// class Game extends StatelessWidget {
//   const Game({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: RenkEslemeEkrani(),
//     );
//   }
// }

// class RenkEslemeEkrani extends StatefulWidget {
//   const RenkEslemeEkrani({super.key});

//   @override
//   _RenkEslemeEkraniState createState() => _RenkEslemeEkraniState();
// }

// class _RenkEslemeEkraniState extends State<RenkEslemeEkrani> {
//   final List<Color> renkler = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange];
//   Color hedefRenk = Colors.red;
//   int puan = 0;
//   int sure = 90;
//   late Timer oyunZamani;

//   @override
//   void initState() {
//     super.initState();
//     rastgeleRenkSec();
//     oyunBaslat();
//   }

//   void rastgeleRenkSec() {
//     setState(() {
//       hedefRenk = renkler[Random().nextInt(renkler.length)];
//     });
//   }

//   void oyunBaslat() {
//     oyunZamani = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (sure > 0) {
//         setState(() {
//           sure--;
//         });
//       } else {
//         timer.cancel();
//         oyunBitti();
//       }
//     });
//   }

//   void oyunBitti() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Oyun Bitti!"),
//         content: Text("Toplam Puanın: $puan"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               oyunuSifirla();
//             },
//             child: const Text("Tekrar Oyna"),
//           )
//         ],
//       ),
//     );
//   }

//   void oyunuSifirla() {
//     setState(() {
//       puan = 0;
//       sure = 30;
//       rastgeleRenkSec();
//       oyunBaslat();
//     });
//   }

//   void kontrolEt(Color secilenRenk) {
//     if (secilenRenk == hedefRenk) {
//       setState(() {
//         puan += 10;
//         rastgeleRenkSec();
//       });
//     } else {
//       setState(() {
//         if (puan > 0) puan -= 5;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Renk Eşleme Oyunu"),
//         backgroundColor: hedefRenk,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             "Bu rengi seç: ",
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: hedefRenk,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.black, width: 2),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Text(
//             "Kalan Süre: $sure saniye",
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             "Puan: $puan",
//             style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 20),
//           Wrap(
//             spacing: 10,
//             runSpacing: 10,
//             children: renkler.map((renk) {
//               return GestureDetector(
//                 onTap: () => kontrolEt(renk),
//                 child: Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: renk,
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black, width: 2),
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     oyunZamani.cancel();
//     super.dispose();
//   }
// }
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RenkEslemeEkrani(),
    );
  }
}

class RenkEslemeEkrani extends StatefulWidget {
  const RenkEslemeEkrani({super.key});

  @override
  _RenkEslemeEkraniState createState() => _RenkEslemeEkraniState();
}

class _RenkEslemeEkraniState extends State<RenkEslemeEkrani> {
  final List<Color> renkler = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange];
  Color hedefRenk = Colors.red;
  int puan = 0;
  int sure = 90;
  Timer? oyunZamani;
  bool oyunDevamEdiyor = false;

  @override
  void initState() {
    super.initState();
    rastgeleRenkSec();
  }

  void rastgeleRenkSec() {
    setState(() {
      hedefRenk = renkler[Random().nextInt(renkler.length)];
    });
  }

  void oyunBaslat() {
    if (oyunZamani != null && oyunZamani!.isActive) return; // Zaten çalışıyorsa başlatma

    setState(() {
      oyunDevamEdiyor = true;
    });

    oyunZamani = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (sure > 0) {
        setState(() {
          sure--;
        });
      } else {
        timer.cancel();
        oyunBitti();
      }
    });
  }

  void oyunDurdur() {
    if (oyunZamani != null) {
      oyunZamani!.cancel();
      setState(() {
        oyunDevamEdiyor = false;
      });
    }
  }

  void oyunBitti() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Oyun Bitti!"),
        content: Text("Toplam Puanın: $puan"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              oyunuSifirla();
            },
            child: const Text("Tekrar Oyna"),
          )
        ],
      ),
    );
  }

  void oyunuSifirla() {
    setState(() {
      puan = 0;
      sure = 90;
      oyunDevamEdiyor = false;
      rastgeleRenkSec();
    });
    oyunBaslat();
  }

  void kontrolEt(Color secilenRenk) {
    if (oyunDevamEdiyor) {
      if (secilenRenk == hedefRenk) {
        setState(() {
          puan += 2;
          rastgeleRenkSec();
        });
      } else {
        setState(() {
          if (puan > 0) puan -= 5;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Renk Eşleme Oyunu",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          ),
              backgroundColor: Color.fromARGB(255, 250, 126, 59), // Arka plan rengi
          // hedefRenk,
        ),
              backgroundColor: const Color.fromARGB(255, 241, 153, 105), // Arka plan rengi

        body: Column(
        
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Bu renk ile eş rengi seç: ",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: screenWidth *0.27,
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                color: hedefRenk,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Kalan Süre: $sure saniye",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Puan: $puan",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            /// 📌 **Kutucuklar Ortaya Alındı**
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: renkler.map((renk) {
                return GestureDetector(
                  onTap: () => kontrolEt(renk),
                  child: Container(
                    width: screenWidth * 0.18,
                    height: screenWidth * 0.18,
                    decoration: BoxDecoration(
                      color: renk,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
      
            /// 📌 **Başlat ve Durdur Butonları**
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton("Başlat", oyunBaslat, Colors.green),
                const SizedBox(width: 20),
                _buildButton("Durdur", oyunDurdur, Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 📌 **Genel Buton Widget'ı**
  Widget _buildButton(String text, VoidCallback onPressed, Color color) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    oyunZamani?.cancel();
    super.dispose();
  }
}
