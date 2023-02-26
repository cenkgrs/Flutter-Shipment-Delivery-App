import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:crud_app/models/Delivery.dart';

class WaitingDeliveries extends StatefulWidget {
  const WaitingDeliveries({Key? key}) : super(key: key);

  @override
  State<WaitingDeliveries> createState() => _WaitingDeliveriesState();
}

class _WaitingDeliveriesState extends State<WaitingDeliveries> {
  late Future<List<Delivery>> futureDeliveries;

  void initState() {
    super.initState();
    futureDeliveries = fetchWaitingDeliveries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Delivery>>(
        future: futureDeliveries,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // return: show loading widget
          }
          if (snapshot.hasError) {
            // return: show error widget
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
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: 400,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              if (delivery.status == 1)
                                Container(
                                    padding: const EdgeInsets.all(12),
                                    width: 200,
                                    child: Align(
                                      alignment: Alignment(-2.5, -1),
                                      child: Icon(Icons.done,
                                          size: 57, color: Colors.blue),
                                    )),
                              Container(
                                width: 400,
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12),
                                        bottomLeft: Radius.circular(12))),
                                child: Text(
                                  delivery.delivery_no,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )));
              });
        });
  }
}
