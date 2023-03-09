import 'package:flutter/material.dart';
import 'package:crud_app/widgets/admin/completed_deliveries_table_widget.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';

class CompletedDeliveriesScene extends StatelessWidget {
  const CompletedDeliveriesScene({Key? key}) : super(key: key);

  static const String _title = 'Tamamlanan Teslimatlar';

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
            body: const CompletedDeliveries(),
            bottomNavigationBar: const BottomNavbar(userType: 'admin', index: 0)));
  }
}
