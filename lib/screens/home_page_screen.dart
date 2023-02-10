import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Aydın Plastik',
      home: Scaffold(
        appBar: AppBar(title: const Text('Aydın Plastik')),
        body: Container(

        )
      ),
    );
  }
}
