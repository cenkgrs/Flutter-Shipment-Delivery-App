import 'package:crud_app/models/Delivery.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:flutter/services.dart';

class DeliveredPersonSheet extends StatefulWidget {
  final String deliveryNo;
  const DeliveredPersonSheet({Key? key, required this.deliveryNo})
      : super(key: key);

  @override
  _DeliveredPersonSheetState createState() => _DeliveredPersonSheetState();
}

class _DeliveredPersonSheetState extends State<DeliveredPersonSheet> {
  String? deliveredPerson;
  TextEditingController deliveryPersonController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            const Text("Lütfen teslim edilen kişinin ismini giriniz",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: TextFormField(
                controller: deliveryPersonController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Teslim Edilen Kişi',
                ),
              ),
            ),
            const Text("TC Kimlik No (Zorunlu Değil)",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: nationalIdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'TC Kimlik No',
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
