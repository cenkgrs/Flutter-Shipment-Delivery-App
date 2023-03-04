import 'package:flutter/material.dart';

class DeliveredPersonSheet extends StatefulWidget {
  const DeliveredPersonSheet({Key? key}) : super(key: key);

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
    ]);
  }
}
