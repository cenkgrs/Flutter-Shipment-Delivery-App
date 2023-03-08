import 'package:flutter/material.dart';
import 'package:crud_app/widgets/driver/completed_deliveries_table_widget.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';

class CompletedDeliveriesScene extends StatelessWidget {
  const CompletedDeliveriesScene({Key? key}) : super(key: key);

  static const String _title = 'Tamamlanan Teslimatlarım';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aydın Plastik',
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
            body: ListView(
              children: <Widget>[
                Row(
                  children: const [
                    Expanded(
                        child: SizedBox(
                            height: 650, child: CompletedDeliveries())),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: const BottomNavbar(userType: 'driver', index: 3)));
  }
}
