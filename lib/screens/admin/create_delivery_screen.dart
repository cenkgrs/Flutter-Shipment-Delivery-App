import 'dart:ffi';
import 'dart:ui';

import 'package:crud_app/models/Delivery.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/widgets/selectBox.dart';

class CreateDeliveryScreen extends StatefulWidget {
  const CreateDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<CreateDeliveryScreen> createState() => _CreateDeliveryScreenState();
}

class _CreateDeliveryScreenState extends State<CreateDeliveryScreen> {
  TextEditingController deliveryNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  int selectedDriver = 1;

  static const String _title = 'Yeni Teslimat Ekle';

  getSelectedDriver(int driverId) {
    selectedDriver = driverId;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
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
            body: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: deliveryNoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'İrsaliye Numarası',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 5,
                        controller: addressController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Teslimat Adresi',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: SelectBox(
                          type: 'drivers', callback: getSelectedDriver),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var result = await createDelivery(
                            deliveryNoController.text.toString(),
                            addressController.text.toString(),
                            selectedDriver);

                        if (result) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Yeni Teslimat Eklendi'),
                            backgroundColor: Colors.blue,
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Yeni Teslimat Eklenemedi. Lütfen Verileri Kontrol Ediniz'),
                            backgroundColor: Colors.blue,
                          ));
                        }
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text('Ekle',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ])));
  }
}
