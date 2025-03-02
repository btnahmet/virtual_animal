import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const BalloonGame());
}

class BalloonGame extends StatelessWidget {
  const BalloonGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BalloonGameScreen(),
    );
  }
}

class BalloonGameScreen extends StatefulWidget {
  const BalloonGameScreen({super.key});

  @override
  _BalloonGameScreenState createState() => _BalloonGameScreenState();
}

class _BalloonGameScreenState extends State<BalloonGameScreen> {
  final List<Balloon> balloons = [];
  final Random random = Random();
  int score = 0;
  int timeLeft = 60;
  bool gameRunning = false;
  bool gamePaused = false;
  Timer? gameTimer;

  @override
  void initState() {
    super.initState();
  }


/// 📌 **Oyunu Başlat veya Devam Ettir**
void startOrResumeGame() {
  if (gamePaused) {
    // Eğer oyun sadece duraklatıldıysa, sadece gamePaused'u false yap ve devam et
    setState(() {
      gamePaused = false;
    });
  } else {
    // Eğer oyun tamamen sıfırdan başlatılıyorsa
    setState(() {
      gameRunning = true;
      gamePaused = false;
      timeLeft = 60;
      score = 0;
      balloons.clear();
    });

    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!gamePaused && timeLeft > 0) {
        setState(() {
          timeLeft--;
          _addBalloon();
        });
      } else if (timeLeft == 0) {
        timer.cancel();
        _endGame();
      }
    });
  }
}

/// 📌 **Oyunu Duraklat**
void pauseGame() {
  setState(() {
    gamePaused = true;
  });
}

/// 📌 **Oyunu Bitirme**
void _endGame() {
  setState(() {
    gameRunning = false;
    gamePaused = false;
  });

  gameTimer?.cancel();
  gameTimer = null;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Oyun Bitti!"),
      content: Text("Toplam Puanın: $score"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            restartGame();
          },
          child: const Text("Tekrar Oyna"),
        ),
      ],
    ),
  );
}

/// 📌 **Oyunu Yeniden Başlat**
void restartGame() {
  setState(() {
    balloons.clear();
    score = 0;
    timeLeft = 60;
    gameRunning = false;
    gamePaused = false;
    gameTimer = null;
  });
}


  /// 📌 **Balon Ekleme**
  void _addBalloon() {
    double left = random.nextDouble() * MediaQuery.of(context).size.width * 0.8;
    setState(() {
      balloons.add(Balloon(
        left: left,
        onTap: _increaseScore,
        onMissed: _removeBalloon,
      ));
    });
  }

  /// 📌 **Balon Patlatıldığında Puan Artırma**
  void _increaseScore() {
    setState(() {
      score += 1;
    });
  }

  /// 📌 **Balon Kaybolduğunda Listeden Çıkarma**
  void _removeBalloon(Balloon balloon) {
    setState(() {
      balloons.remove(balloon);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blue[100], // Gök yüzü arka planı
      appBar: AppBar(
        title: const Text("Balon Patlatma Oyunu"),
        backgroundColor: Colors.blueAccent,
        actions: [
          if (gameRunning && !gamePaused)
            IconButton(
              icon: const Icon(Icons.pause, color: Colors.white),
              onPressed: pauseGame,
            ),
          if (gamePaused)
            IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              onPressed: startOrResumeGame,
            ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: screenWidth * 0.05,
            child: Text(
              "Süre: $timeLeft sn",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 10,
            right: screenWidth * 0.05,
            child: Text(
              "Puan: $score",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          ...balloons,
          if (!gameRunning)
            Center(
              child: ElevatedButton(
                onPressed: startOrResumeGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  "Oyunu Başlat",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
  }
}

/// 📌 **Balon Widget**
class Balloon extends StatefulWidget {
  final double left;
  final VoidCallback onTap;
  final Function(Balloon) onMissed;

  const Balloon({required this.left, required this.onTap, required this.onMissed, super.key});

  @override
  _BalloonState createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> {
  double top = 600;
  bool isPopped = false;
  Timer? _moveTimer;

  @override
  void initState() {
    super.initState();
    _moveBalloon();
  }

  /// 📌 **Balon Hareketi**
  void _moveBalloon() {
    _moveTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (top > -70 && !isPopped) { // 🛑 Balon en üste çıkarsa kaybolacak
        setState(() {
          top -= 5;
        });
      } else {
        timer.cancel();
        if (!isPopped) {
          widget.onMissed(widget); // 🟢 Balon ekran dışına çıkınca listeden kaldır
        }
      }
    });
  }

  /// 📌 **Balona Tıklama (Patlatma)**
  void _popBalloon() {
    if (!isPopped) {
      setState(() {
        isPopped = true;
      });
      widget.onTap();
      _moveTimer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 50),
      left: widget.left,
      top: top,
      child: GestureDetector(
        onTap: _popBalloon,
        child: isPopped
            ? const SizedBox.shrink()
            : Container(
                width: 50,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _moveTimer?.cancel();
    super.dispose();
  }
}
