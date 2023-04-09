import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:crud_app/models/Delivery.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class ActiveDeliveries extends StatefulWidget {
  const ActiveDeliveries({Key? key}) : super(key: key);

  @override
  State<ActiveDeliveries> createState() => _ActiveDeliveriesState();
}

class _ActiveDeliveriesState extends State<ActiveDeliveries> {
  late Future<List<Delivery>> futureDeliveries;
  DateFormat? dateFormat;
  DateFormat? timeFormat;

  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMd('tr');
    timeFormat = DateFormat.Hms('tr');
    futureDeliveries = fetchActiveDeliveries();
  }

  Container getDeliveryIcon(delivery) {
    return Container(
        padding: const EdgeInsets.all(12),
        width: 200,
        child: const Align(
          alignment: Alignment(-1, -1),
          child: Icon(Icons.track_changes, size: 45, color: Colors.blue),
        ));
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
                  fontSize: 10,
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

  Container getDeliveryStartTime(delivery) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment(-1, -1),
                  child: Icon(Icons.start, size: 30, color: Colors.blueAccent),
                )
              ],
            ),
          ),
          Expanded(
              flex: 8,
              child: Column(
                children: <Widget>[
                  Text(
                    '${dateFormat!.format(delivery.tt_delivery)} ${timeFormat!.format(delivery.tt_delivery)}',
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
                            child: Text('Aktif Teslimat Bulunamadı')))));
          }
          List<Delivery> deliveries = snapshot.data ?? [];

          if (deliveries.isEmpty) {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: const Visibility(
                        visible: true,
                        child: Center(
                            // scaffold of the app
                            child: Text('Aktif Teslimat Bulunmuyor')))));
          }

          return ListView.builder(
              itemCount: deliveries.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                Delivery delivery = deliveries[index];

                return Center(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: 400,
                          height: 175,
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
                                          const SizedBox(height: 10),
                                          getAddress(delivery)
                                        ],
                                      ))
                                ],
                              ),
                              getDeliveryStartTime(delivery),
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
                                  ],
                                ),
                              )
                            ],
                          ),
                        )));
              });
        });
  }
}
