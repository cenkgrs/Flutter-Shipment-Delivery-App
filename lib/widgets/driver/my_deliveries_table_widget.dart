import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:crud_app/models/Delivery.dart';

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
          child: Align(
            alignment: Alignment(-1, -1),
            child: Icon(Icons.done, size: 57, color: Colors.blue),
          ));
    } else {
      return Container(
          padding: const EdgeInsets.all(12),
          width: 200,
          child: Align(
            alignment: Alignment(-1, -1),
            child: Icon(Icons.track_changes, size: 57, color: Colors.blue),
          ));
    }
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
        Column(
          children: <Widget>[
            Text(
              delivery.address,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 8,
                  fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    );
  }

  Container getDeliveryNo(delivery, width) {
    return Container(
      width: width * 0.9,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12))),
      child: Text(
        delivery.delivery_no,
        style: TextStyle(
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
                //  DateFormat("yyyy-MM-dd").format(
                //     DateTime.parse(respondedData3['data'][index]['appointmentDate']));

                return Center(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                                    child: getDeliveryIcon(delivery),
                                  ),
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
                              Row(
                                children: <Widget>[
                                  getDeliveryNo(delivery, width)
                                ],
                              )
                            ],
                          ),
                        )));
              });
        });
  }
}
