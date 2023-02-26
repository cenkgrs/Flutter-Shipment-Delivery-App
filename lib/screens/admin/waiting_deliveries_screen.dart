import 'package:flutter/material.dart';
import 'package:crud_app/widgets/admin/waiting_deliveries_table_widget.dart';

class WaitingDeliveriesScreen extends StatelessWidget {
  const WaitingDeliveriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aydın Plastik',
        home: Scaffold(
          appBar: AppBar(title: const Text('Aydın Plastik')),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
 
                Row(
                  children: [
                    Expanded(
                        child:
                            SizedBox(height: 650, child: WaitingDeliveries())),
                  ],
                ),
           
            ],
          ),
        ));
  }
}
