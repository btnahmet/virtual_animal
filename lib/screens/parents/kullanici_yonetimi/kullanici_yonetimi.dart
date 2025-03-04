import 'package:flutter/material.dart';

class KullaniciYonetimi extends StatefulWidget {
  const KullaniciYonetimi({super.key});

  @override
  State<KullaniciYonetimi> createState() => _KullaniciYonetimiState();
}

class _KullaniciYonetimiState extends State<KullaniciYonetimi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kullanıcı Yönetimi'),
        
      ));
  }
}