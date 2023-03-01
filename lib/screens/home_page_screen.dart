import 'package:flutter/material.dart';
import 'package:crud_app/widgets/driver/add_way_bill_card_widget.dart';
import 'package:crud_app/widgets/driver/my_deliveries_table_widget.dart';

import 'package:crud_app/widgets/admin/completed_deliveries_card_widget.dart';
import 'package:crud_app/widgets/admin/create_delivery_card_widget.dart';
import 'package:crud_app/widgets/admin/waiting_deliveries_card_widget.dart';
import 'package:crud_app/widgets/admin/driver_locations_card_widget.dart';
import 'package:crud_app/screens/search_screen.dart';
import 'package:crud_app/main.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';


class HomeScreen extends StatelessWidget {
  final String userType;

  HomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Aydın Plastik',
        home: Scaffold(
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
                        child:
                            SizedBox(height: 650, child: MyDeliveriesTable())),
                  ],
                ),
              if (userType == 'admin')
                Row(
                  children: const [Expanded(child: CreateDeliveryCard())],
                ),
              if (userType == 'admin')
                Row(
                  children: const [Expanded(child: CompletedDeliveriesCard())],
                ),
              if (userType == 'admin')
                Row(
                  children: const [Expanded(child: WaitingDeliveriesCard())],
                ),
              if (userType == 'admin')
                Row(
                  children: const [Expanded(child: DriverLocations())],
                ),
            ],
          ),
          bottomNavigationBar: BottomNavbar(userType: userType, index: 0)
        ));
  }
}
