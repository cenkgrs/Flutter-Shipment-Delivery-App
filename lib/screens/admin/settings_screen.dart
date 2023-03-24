import 'package:flutter/material.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:crud_app/screens/admin/create_driver_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const String _title = 'Ayarlar';

  @override
  void initState() {
    super.initState();
  }

  createDriverCard(width) {
    return SizedBox(
      width: width * 0.8,
      child: FittedBox(
          child: FloatingActionButton.extended(
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateDriverScreen()),
                );
              },
              backgroundColor: Colors.blue,
              splashColor: Colors.blueAccent,
              icon: const Icon(Icons.add),
              label: const Text('Şöför Ekle'))),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
        title: _title,
        home: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: const Text(_title),
              centerTitle: true,
            ),
            body: ListView(children: [
              createDriverCard(width),
            ]),
            bottomNavigationBar:
                const BottomNavbar(userType: 'admin', index: 0)));
  }
}
