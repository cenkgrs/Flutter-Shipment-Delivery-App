import 'package:crud_app/models/Delivery.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:flutter/services.dart';

class DeliveredPersonSheet extends StatefulWidget {
  final String deliveryNo;
  DeliveredPersonSheet({Key? key, required this.deliveryNo})
      : super(key: key);

  @override
  _DeliveredPersonSheetState createState() => _DeliveredPersonSheetState();
}

class _DeliveredPersonSheetState extends State<DeliveredPersonSheet> {
  String? deliveredPerson;
  TextEditingController deliveryPersonController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();

  bool _isLoading = false;

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
      Visibility(
        visible: _isLoading,
        child: const CircularProgressIndicator(),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: FloatingActionButton.extended(
                heroTag: UniqueKey(),
                onPressed: () async{
                  showLoading();

                  var person = deliveryPersonController.text.toString();
                  var nationalId = nationalIdController.toString();

                  var result = await completeDelivery(widget.deliveryNo, person, nationalId);

                  if (result == true) {
                    hideLoading();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(userType: 'driver')),
                    );
                  } else {
                    hideLoading();

                    // Give error message here
                  }
                },
                backgroundColor: Colors.blueAccent,
                splashColor: Colors.blue,
                icon: const Icon(Icons.done_outline),
                label: const Text('Tamamla'))),
      )
    ]);
  }

    void showLoading() {
    setState(() => _isLoading = true);
  }

  void hideLoading() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
