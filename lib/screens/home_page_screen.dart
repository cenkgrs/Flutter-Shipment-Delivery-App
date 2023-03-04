import 'package:flutter/material.dart';
import 'package:crud_app/widgets/driver/add_way_bill_card_widget.dart';
import 'package:crud_app/widgets/driver/my_deliveries_table_widget.dart';

import 'package:crud_app/widgets/admin/completed_deliveries_card_widget.dart';
import 'package:crud_app/widgets/admin/create_delivery_card_widget.dart';
import 'package:crud_app/widgets/admin/waiting_deliveries_card_widget.dart';
import 'package:crud_app/widgets/admin/driver_locations_card_widget.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';

import 'package:crud_app/screens/driver/delivery_screen.dart';

import 'package:provider/provider.dart';
import 'package:crud_app/themes/themes.dart';

class HomeScreen extends StatelessWidget {
  final String userType;

  HomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => AppTheme(),
      child: Consumer<AppTheme>(builder: (context, state, child) {
        return MaterialApp(
            title: 'Aydın Plastik',
            /*theme: state.darkTheme
                ? ThemeData(
                    appBarTheme: AppBarTheme(color: Color(0xff181823)),
                    colorScheme: const ColorScheme.dark().copyWith(
                      primary: Color(0xff2C74B3),
                      secondary: Color(0xff2C74B3),
                      brightness: Brightness.dark,
                    ),
                    scaffoldBackgroundColor: Color(0xff181823))
                : ThemeData(
                    colorScheme: const ColorScheme.light().copyWith(
                      secondary: Colors.blue,
                      brightness: Brightness.light,
                    ),
                    scaffoldBackgroundColor: Colors.lightBlue),*/
            home: Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeliveryScreen()),
                    );
                  },
                  child: const Icon(Icons.delivery_dining), //icon inside button
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                appBar: AppBar(title: const Text('Aydın Plastik')),
                body: ListView(
                  children: <Widget>[
                    /*
              if (userType == 'driver')
                Row(children: const [
                  Expanded(
                    child: AddWayBillCard(),
                  ),
                ]),
              */
                    if (userType == 'driver')
                      Row(
                        children: const [
                          Expanded(
                              child: SizedBox(
                                  height: 650, child: MyDeliveriesTable())),
                        ],
                      ),
                    if (userType == 'admin')
                      Row(
                        children: const [Expanded(child: CreateDeliveryCard())],
                      ),
                    if (userType == 'admin')
                      Row(
                        children: const [
                          Expanded(child: CompletedDeliveriesCard())
                        ],
                      ),
                    if (userType == 'admin')
                      Row(
                        children: const [
                          Expanded(child: WaitingDeliveriesCard())
                        ],
                      ),
                    if (userType == 'admin')
                      Row(
                        children: const [Expanded(child: DriverLocations())],
                      ),
                  ],
                ),
                bottomNavigationBar:
                    BottomNavbar(userType: userType, index: 0)));
      }));
}
