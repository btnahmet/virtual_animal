// import 'package:flutter/material.dart';

// class Game extends StatefulWidget {
//   const Game({super.key});

//   @override
//   State<Game> createState() => _GameState();
// }

// class _GameState extends State<Game> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(Game());
}

class Game extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RenkEslemeEkrani(),
    );
  }
}

class RenkEslemeEkrani extends StatefulWidget {
  @override
  _RenkEslemeEkraniState createState() => _RenkEslemeEkraniState();
}

class _RenkEslemeEkraniState extends State<RenkEslemeEkrani> {
  final List<Color> renkler = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.orange];
  Color hedefRenk = Colors.red;
  int puan = 0;
  int sure = 30;
  late Timer oyunZamani;

  @override
  void initState() {
    super.initState();
    rastgeleRenkSec();
    oyunBaslat();
  }

  void rastgeleRenkSec() {
    setState(() {
      hedefRenk = renkler[Random().nextInt(renkler.length)];
    });
  }

  void oyunBaslat() {
    oyunZamani = Timer.periodic(Duration(seconds: 1), (timer) {
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

  void oyunBitti() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Oyun Bitti!"),
        content: Text("Toplam Puanın: $puan"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              oyunuSifirla();
            },
            child: Text("Tekrar Oyna"),
          )
        ],
      ),
    );
  }

  void oyunuSifirla() {
    setState(() {
      puan = 0;
      sure = 30;
      rastgeleRenkSec();
      oyunBaslat();
    });
  }

  void kontrolEt(Color secilenRenk) {
    if (secilenRenk == hedefRenk) {
      setState(() {
        puan += 10;
        rastgeleRenkSec();
      });
    } else {
      setState(() {
        if (puan > 0) puan -= 5;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Renk Eşleme Oyunu"),
        backgroundColor: hedefRenk,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Bu rengi seç: ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: hedefRenk,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Kalan Süre: $sure saniye",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Puan: $puan",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: renkler.map((renk) {
              return GestureDetector(
                onTap: () => kontrolEt(renk),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: renk,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    oyunZamani.cancel();
    super.dispose();
  }
}
