import 'package:flutter/material.dart';

import '../components/curtain1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giggle Cast'),
      ),
      body: const Stack(
        children: [
          Curtain1(containerHeight: 250),
        ],
      ),
    );
  }
}
