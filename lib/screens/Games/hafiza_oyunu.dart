import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  final List<String> _emojis = ["🐶", "🐱", "🐹", "🐰", "🐻", "🦊", "🐼", "🐸"];
  late List<String> _gameBoard;
  late List<bool> _revealed;
  late List<bool> _matched;
  int _score = 0;
  int _matchesFound = 0;
  int? _firstSelectedIndex;
  bool _gameFinished = false;
  bool _waiting =
      false; // 🔹 **Yeni eklenen değişken** (setState çağrısını engeller)

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    setState(() {
      _gameBoard = List.from(_emojis)..addAll(_emojis);
      _gameBoard.shuffle(Random());
      _revealed = List.generate(_gameBoard.length, (_) => false);
      _matched = List.generate(_gameBoard.length, (_) => false);
      _score = 0;
      _matchesFound = 0;
      _firstSelectedIndex = null;
      _gameFinished = false;
      _waiting = false;
    });
  }

  void _selectCard(int index) {
    if (_revealed[index] || _matched[index] || _gameFinished || _waiting) {
      return;
    }

    setState(() {
      _revealed[index] = true;
    });

    if (_firstSelectedIndex == null) {
      _firstSelectedIndex = index;
    } else {
      _waiting =
          true; // ⏳ **Bekleme başlatılıyor, tekrar tıklama engelleniyor**

      if (_gameBoard[_firstSelectedIndex!] == _gameBoard[index]) {
        // ✅ **Çift bulundu, kartlar hemen kayboluyor**
        setState(() {
          _score += 1;
          _matched[_firstSelectedIndex!] = true;
          _matched[index] = true;
          _matchesFound++;
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          _waiting = false;
          _firstSelectedIndex = null;

          // 🎉 **Oyun tamamlandı mı kontrol et**
          if (_matchesFound == _emojis.length) {
            _finishGame();
          }
        });
      } else {
        // ❌ **Yanlış eşleşme, 1 saniye sonra geri kapat**
        setState(() {
          //_score -= 5;
        });

        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            setState(() {
              _revealed[index] = false;
              _revealed[_firstSelectedIndex!] = false;
              _firstSelectedIndex = null;
              _waiting = false; // ⏳ **Bekleme kaldırılıyor**
            });
          }
        });
      }
    }
  }

  void _finishGame() {
    setState(() {
      _gameFinished = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Oyun Bitti!"),
          content: Text("Tebrikler! Toplam Puanın: $_score"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _startNewGame();
              },
              child: const Text("Tekrar Oyna"),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: const Text("Hafıza Oyunu",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          ),
          backgroundColor: const Color.fromARGB(255, 175, 129, 255),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Puan: $_score",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _gameBoard.length,
                  itemBuilder: (context, index) {
                    if (_matched[index]) {
                      return const SizedBox
                          .shrink(); // ✅ **Çifti eşleşen kart yok ediliyor**
                    }

                    return GestureDetector(
                      onTap: () => _selectCard(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: _revealed[index]
                              ? Colors.white
                              : Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _revealed[index] ? _gameBoard[index] : "❓",
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _startNewGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                "Yeni Oyun Başlat",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
