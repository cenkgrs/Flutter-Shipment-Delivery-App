import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:crud_app/models/Delivery.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyDeliveriesTable extends StatefulWidget {
  const MyDeliveriesTable({Key? key}) : super(key: key);

  @override
  State<MyDeliveriesTable> createState() => _MyDeliveriesTableState();
}

class _MyDeliveriesTableState extends State<MyDeliveriesTable> {
  late Future<List<Delivery>> futureDeliveries;

  void initState() {
    super.initState();
    futureDeliveries = fetchDeliveries();
  }

  Container getDeliveryIcon(delivery) {
    if (delivery.status == 1) {
      return Container(
          padding: const EdgeInsets.all(12),
          width: 200,
          child: const Align(
            alignment: Alignment(-1, -1),
            child: Icon(Icons.task_alt, size: 57, color: Colors.blue),
          ));
    } else {
      return Container(
          padding: const EdgeInsets.all(12),
          width: 200,
          child: const Align(
            alignment: Alignment(-1, -1),
            child: Icon(Icons.track_changes, size: 57, color: Colors.blue),
          ));
    }
  }

  GestureDetector getDeliveryAction(delivery) {
    if (delivery.status == 0 && delivery.st_delivery == 0) {
      return GestureDetector(
          onTap: () {
            startDelivery(delivery);
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            width: 200,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text('Teslimatı Başlat',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ));
    }

    if (delivery.status == 0 && delivery.st_delivery == 1) {
      return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(12),
            width: 200,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: const Center(
              child: Text('Devam Ediyor',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ));
    }

    // Empty
    return GestureDetector(
      onTap: () {},
      child: Container(),
    );
  }

  Row getDriverName(delivery) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            Icon(Icons.person, size: 16, color: Colors.grey.shade700),
          ],
        ),
        Column(
          children: <Widget>[
            Text(
              delivery.driver_name,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Row getAddress(delivery) {
    return Row(
      children: [
        Column(
          children: <Widget>[
            Icon(Icons.location_on, size: 14, color: Colors.grey.shade700),
          ],
        ),
        Flexible(
            child: Column(
          children: <Widget>[
            Text(
              delivery.address,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 8,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ))
      ],
    );
  }

  Container getDeliveryNo(delivery, width) {
    return Container(
      width: width * 0.9,
      padding: const EdgeInsets.all(12),
      child: Text(
        delivery.delivery_no,
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Delivery>>(
        future: futureDeliveries,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Visibility(
                        visible: true,
                        child: Center(
                          // scaffold of the app
                          child: LoadingAnimationWidget.hexagonDots(
                            color: Colors.blue,
                            size: 50,
                          ),
                        ))));
          }
          if (snapshot.hasError) {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: const Visibility(
                        visible: true,
                        child: Center(
                            // scaffold of the app
                            child: Text('Teslimat Bulunamadı')))));
          }
          List<Delivery> deliveries = snapshot.data ?? [];
          return ListView.builder(
              itemCount: deliveries.length,
              //  respondedData3['data'].length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                Delivery delivery = deliveries[index];

                return Center(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                        child: Container(
                          width: width * 0.9,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: <Widget>[
                                          getDeliveryIcon(delivery),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Column(
                                        children: <Widget>[
                                          getDriverName(delivery),
                                          getAddress(delivery)
                                        ],
                                      ))
                                ],
                              ),
                              Expanded(
                                  child: Container(
                                width: 100,
                              )),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12),
                                        bottomLeft: Radius.circular(12))),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 6,
                                      child: getDeliveryNo(delivery, width),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: getDeliveryAction(delivery))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )));
              });
        });
  }

  startDelivery(Delivery delivery) async {
    const storage = FlutterSecureStorage();

    // to get token from local storage
    var token = await storage.read(key: 'token');

    try {
      final response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/start-delivery'),
          headers: {
            'Accept': 'application/json;',
            'Authorization': 'Bearer $token'
          },
          body: {
            'delivery_no': delivery.delivery_no,
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Teslimat Başlatıldı !'),
            backgroundColor: Colors.blue,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Teslimat Başlatılamadı Lütfen Sayfayı Tekrardan Açınız !'),
            backgroundColor: Colors.blue,
          ));
        }
      } else {
        throw Exception(
            'Teslimat Başlatılamadı Lütfen Sayfayı Tekrardan Açınız.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
        backgroundColor: Colors.blue,
      ));
    }
  }
}
