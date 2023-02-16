import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:crud_app/widgets/selectBox.dart';

class CreateDeliveryScreen extends StatefulWidget {
  const CreateDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<CreateDeliveryScreen> createState() =>
      _CreateDeliveryScreenState();
}

class _CreateDeliveryScreenState extends State<CreateDeliveryScreen> {
  TextEditingController deliveryNo = TextEditingController();
  TextEditingController deliveryPerson = TextEditingController();

  static const String _title = 'Teslimat Kaydı Ekle';

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
                        controller: deliveryNo,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'İrsaliye Numarası',
                        ),
                      ),
                    ),
                    Container(
                      child: SelectBox(type: 'waiting_deliveries'),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: deliveryPerson,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Teslim Edilen Kişi',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text('Teslimatı Tamamla',
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
