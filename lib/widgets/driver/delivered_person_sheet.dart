import 'package:crud_app/models/Delivery.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/screens/home_page_screen.dart';

class DeliveredPersonSheet extends StatefulWidget {
  final String deliveryNo;
  const DeliveredPersonSheet({Key? key, required this.deliveryNo})
      : super(key: key);

  @override
  _DeliveredPersonSheetState createState() => _DeliveredPersonSheetState();
}

class _DeliveredPersonSheetState extends State<DeliveredPersonSheet> {
  int? deliveredPerson;
  TextEditingController deliveryPersonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: deliveryPersonController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Teslim Edilen Kişi',
                ),
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: FloatingActionButton.extended(
                heroTag: UniqueKey(),
                onPressed: () {
                  completeDelivery(widget.deliveryNo,
                      deliveryPersonController.text.toString());

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(userType: 'driver')),
                  );
                },
                backgroundColor: Colors.blueAccent,
                splashColor: Colors.blue,
                icon: const Icon(Icons.done_outline),
                label: const Text('Tamamla'))),
      )
    ]);
  }
}
