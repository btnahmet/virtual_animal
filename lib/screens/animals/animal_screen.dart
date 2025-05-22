import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:virtual_animal/screens/animals/animal_model.dart';
import 'package:virtual_animal/database/database_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
  late AnimalModel _animalModel;
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  Timer? _updateTimer;

  @override
  void initState() {
    super.initState();
    _animalModel = widget.animalModel;
    _initializeNotifications();
    _loadAnimalData();
    // Her dakika parametreleri güncelle
    _updateTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateParameters();
    });
  }

  // Bildirim sistemini başlat
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _notifications.initialize(initializationSettings);
  }

  // Bildirim gösterme
  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'animal_care_channel',
      'Hayvan Bakım Bildirimleri',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _notifications.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  // Parametreleri güncelle
  Future<void> _updateParameters() async {
    if (_animalModel.lastUpdateTime.isNotEmpty) {
      DateTime lastUpdate = DateTime.tryParse(_animalModel.lastUpdateTime) ?? DateTime.now();
      setState(() {
        _animalModel.updateParametersBasedOnTime(lastUpdate);
      });
      await _databaseHelper.updateAnimal(_animalModel.toMap());
      _checkAndShowNotifications();
    }
  }

  // Bildirimleri kontrol et ve göster
  void _checkAndShowNotifications() {
    if (_animalModel.shouldNotifyHealth()) {
      _showNotification(
        'Sağlık Uyarısı',
        '${widget.animalName}ın sağlık durumu kritik seviyede!',
      );
    }
    if (_animalModel.shouldNotifyHappiness()) {
      _showNotification(
        'Mutluluk Uyarısı',
        '${widget.animalName}ın mutluluk seviyesi düşük!',
      );
    }
    if (_animalModel.shouldNotifyHunger()) {
      _showNotification(
        'Açlık Uyarısı',
        '${widget.animalName} aç!',
      );
    }
  }

  // Hayvan verilerini yükle
  Future<void> _loadAnimalData() async {
    final animals = await _databaseHelper.getAnimals();
    final animalData = animals.where((animal) => animal['type'] == widget.animalName).toList();
    if (animalData.isNotEmpty) {
      AnimalModel loaded = AnimalModel.fromMap(animalData.first);
      if (loaded.lastUpdateTime.isNotEmpty) {
        DateTime lastUpdate = DateTime.tryParse(loaded.lastUpdateTime) ?? DateTime.now();
        loaded.updateParametersBasedOnTime(lastUpdate);
        await _databaseHelper.updateAnimal(loaded.toMap());
      }
      setState(() {
        _animalModel = loaded;
      });
      _checkAndShowNotifications();
    } else {
      _animalModel.type = widget.animalName;
      _animalModel.lastUpdateTime = DateTime.now().toIso8601String();
      final id = await _databaseHelper.insertAnimal(_animalModel.toMap());
      setState(() {
        _animalModel.id = id;
      });
    }
  }

  // Hayvan durumunu güncelle
  Future<void> _updateStatus(String action) async {
    setState(() {
      _animalModel.updateStatus(action);
      _animalModel.lastUpdateTime = DateTime.now().toIso8601String();
    });
    if (_animalModel.id != null) {
      await _databaseHelper.updateAnimal(_animalModel.toMap());
    }
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    super.dispose();
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
                      _buildActionButton("Besle", () => _updateStatus("feed")),
                      _buildActionButton("Temizle", () => _updateStatus("clean")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton("Oyna", () => _updateStatus("play")),
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

  // Grafik oluştur
  Widget _buildChart(double screenWidth) {
    return SizedBox(
      height: 150,
      width: screenWidth * 0.9,
      child: BarChart(
        BarChartData(
          maxY: 100,
          barGroups: [
            _buildBarGroup(0, "Sağlık", _animalModel.health),
            _buildBarGroup(1, "Mutluluk", _animalModel.happiness),
            _buildBarGroup(2, "Açlık", _animalModel.hunger),
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

  // Grafik çubukları oluştur
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

  // Aksiyon butonları oluştur
  Widget _buildActionButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 150,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFA07A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.zero,
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
