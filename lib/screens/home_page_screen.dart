import 'package:flutter/material.dart';
import 'package:crud_app/widgets/driver/my_deliveries_table_widget.dart';

import 'package:crud_app/widgets/admin/active_deliveries_card_widget.dart';
import 'package:crud_app/widgets/admin/completed_deliveries_card_widget.dart';
import 'package:crud_app/widgets/admin/create_delivery_card_widget.dart';
import 'package:crud_app/widgets/admin/waiting_deliveries_card_widget.dart';
import 'package:crud_app/widgets/admin/driver_locations_card_widget.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';

import 'package:crud_app/screens/driver/delivery_screen.dart';
import 'package:crud_app/screens/admin/drivers_screen.dart';

import 'package:provider/provider.dart';
import 'package:crud_app/themes/themes.dart';

class HomeScreen extends StatelessWidget {
  final String userType;

  const HomeScreen({Key? key, required this.userType}) : super(key: key);

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
                  heroTag: UniqueKey(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => userType == 'driver'
                              ? const DeliveryScreen()
                              : const DriversScreen()),
                    );
                  },
                  child: userType == 'driver'
                      ? const Icon(Icons.delivery_dining)
                      : const Icon(Icons.people), //icon inside button
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
                    if (userType == 'driver') const MyDeliveriesTable(),
                    if (userType == 'admin')
                      const Row(
                        children: [Expanded(child: CreateDeliveryCard())],
                      ),
                    if (userType == 'admin')
                      const Row(
                        children: [Expanded(child: CompletedDeliveriesCard())],
                      ),
                    if (userType == 'admin')
                      const Row(
                        children: [Expanded(child: ActiveDeliveriesCard())],
                      ),
                    if (userType == 'admin')
                      const Row(
                        children: [Expanded(child: WaitingDeliveriesCard())],
                      ),
                    if (userType == 'admin')
                      const Row(
                        children: [Expanded(child: DriverLocations())],
                      ),
                  ],
                ),
                bottomNavigationBar:
                    BottomNavbar(userType: userType, index: 0)));
      }));
}
