import 'package:flutter/material.dart';
import 'package:crud_app/models/Delivery.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DeliveryCard extends StatefulWidget {
  final Delivery delivery;

  const DeliveryCard({Key? key, required this.delivery}) : super(key: key);

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  late Future<List<Delivery>> futureDeliveries;
  DateFormat? dateFormat;
  DateFormat? timeFormat;

  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMEEEEd('tr');
    timeFormat = DateFormat.Hms('tr');
  }

  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(10),
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
                              const SizedBox(height: 5),
                              getAddress(delivery)
                            ],
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 10,
                          child: Column(children: <Widget>[
                            getDeliveryStartTime(delivery),
                          ])),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 10,
                          child: Column(children: <Widget>[
                            getDeliveryCompleteTime(delivery),
                          ])),
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
                      ],
                    ),
                  )
                ],
              ),
            )));
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

  Container getDeliveryStartTime(delivery) {
    if (delivery.st_complete == 0) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: const <Widget>[
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
                    dateFormat!.format(delivery.tt_delivery) +
                        ' ' +
                        timeFormat!.format(delivery.tt_delivery),
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

  Container getDeliveryCompleteTime(delivery) {
    if (delivery.st_complete == 0) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: const <Widget>[
                Align(
                  alignment: Alignment(-1, -1),
                  child: Icon(Icons.timelapse_outlined,
                      size: 30, color: Colors.blueAccent),
                )
              ],
            ),
          ),
          Expanded(
              flex: 8,
              child: Column(
                children: <Widget>[
                  Text(
                    dateFormat!.format(delivery.tt_complete) +
                        ' ' +
                        timeFormat!.format(delivery.tt_complete),
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
}
