import 'package:flutter/material.dart';
import 'package:crud_app/widgets/driver/completed_deliveries_table_widget.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:crud_app/screens/driver/delivery_screen.dart';

class CompletedDeliveriesScene extends StatelessWidget {
  const CompletedDeliveriesScene({Key? key}) : super(key: key);

  static const String _title = 'Tamamlanan Teslimatlarım';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aydın Plastik',
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
              heroTag: UniqueKey(),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeliveryScreen()),
                );
              },
              child: const Icon(Icons.delivery_dining),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
            body: const CompletedDeliveries(),
            bottomNavigationBar:
                const BottomNavbar(userType: 'driver', index: 3)));
  }
}
