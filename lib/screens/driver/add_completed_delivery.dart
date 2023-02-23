import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:crud_app/widgets/selectBox.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class AddCompletedDeliveryScene extends StatefulWidget {
  const AddCompletedDeliveryScene({Key? key}) : super(key: key);

  @override
  State<AddCompletedDeliveryScene> createState() =>
      _AddCompletedDeliverySceneState();
}

class _AddCompletedDeliverySceneState extends State<AddCompletedDeliveryScene> {
  TextEditingController deliveryNoController = TextEditingController();
  TextEditingController deliveryPersonController = TextEditingController();

  String selectedDeliveryNo = "";

  bool _isLoading = false;

  static const String _title = 'Teslimat Kaydı Ekle';

  getSelectedDelivery(String deliveryNo) {
    selectedDeliveryNo = deliveryNo;
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
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: SelectBox(type: 'waiting_deliveries', callback: getSelectedDelivery),
                    ),
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
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        completeDelivery(deliveryNoController.text.toString(),
                            deliveryPersonController.text.toString());
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text('Teslimatı Tamamla',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Visibility(
                      visible: _isLoading,
                      child: Center(
                        // scaffold of the app
                        child: LoadingAnimationWidget.hexagonDots(
                          color: Colors.blue,
                          size: 50,
                        ),
              )))),
            ])));
  }

  void completeDelivery(String deliveryNo, String deliveredPerson) async {

    if (selectedDeliveryNo == '') {
      return;
    }

    showLoading();

    print("here");

    final storage = const FlutterSecureStorage();

    // to get token from local storage
    var token = await storage.read(key: 'token');

    try {
      final response = await http
          .post(Uri.parse('http://127.0.0.1:8000/api/complete-delivery'), headers: {
        'Accept': 'application/json;',
        'Authorization': 'Bearer $token'
      }, body: {
        'delivery_no': selectedDeliveryNo,
        'delivered_person': deliveredPerson
      }); //'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Teslimat Tamamlandı !'),
            backgroundColor: Colors.blue,
          ));
      
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Teslimat kaydı eklenemedi Lütfen irsaliye numarasını kontrol ediniz !'),
            backgroundColor: Colors.blue,
          ));
        }

        hideLoading();

      } else {
        throw Exception(
            'Teslimat kaydı eklenemedi Lütfen irsaliye numarasını kontrol ediniz.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
        backgroundColor: Colors.blue,
      ));

      hideLoading();


    }
  }

  void showLoading() {
    setState(() => _isLoading = true);
  }

  void hideLoading() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      // Here you can write your code

      setState(() {
        _isLoading = false;
      });
    });
  }
}
