import 'package:flutter/material.dart';
import 'package:crud_app/widgets/admin/waiting_deliveries_table_widget.dart';

class WaitingDeliveriesScreen extends StatelessWidget {
  const WaitingDeliveriesScreen({Key? key}) : super(key: key);

  static const String _title = 'Bekleyen Teslimatlar';

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
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: const Text(_title),
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: SizedBox(height: 650, child: WaitingDeliveries())),
                ],
              ),
            ],
          ),
        ));
  }
}
