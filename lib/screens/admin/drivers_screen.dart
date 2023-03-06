import 'package:crud_app/models/Driver.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/widgets/selectBox.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';

class DriversScreen extends StatefulWidget {
  const DriversScreen({Key? key}) : super(key: key);

  @override
  State<DriversScreen> createState() => _DriversScreenState();
}

class _DriversScreenState extends State<DriversScreen> {

  static const String _title = 'Şöförler Şuan Nerede ?';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            body: Stack(children: const <Widget>[
            ]),
            bottomNavigationBar: const BottomNavbar(userType: 'admin', index: 0)));
  }
}
