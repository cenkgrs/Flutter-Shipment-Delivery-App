import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:crud_app/screens/admin/drivers_screen.dart';
import 'package:crud_app/models/Driver.dart';

// Models
import 'package:crud_app/models/Delivery.dart';

class DriverDetailsScreen extends StatefulWidget {

  final int id;

  const DriverDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  late Future<Delivery> futureDriver;
  DateFormat? dateFormat;
  DateFormat? timeFormat;

  @override
  void initState() {
    super.initState();
    futureDriver = getDriver(widget.id);
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMEEEEd('tr');
    timeFormat = DateFormat.Hms('tr');
  }

  bool _isLoading = false;

  String address = "";

  static const String _title = 'Şöför Bilgileri';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
        title: _title,
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DriversScreen()),
                );
              },
              child: const Icon(Icons.people), //icon inside button
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            appBar: AppBar(
              title: const Text(_title),
              centerTitle: true,
            ),
            body: Stack(),
            bottomNavigationBar:
                const BottomNavbar(userType: 'admin', index: 3)));
  }

  void showLoading() {
    setState(() => _isLoading = true);
  }

  void hideLoading() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
