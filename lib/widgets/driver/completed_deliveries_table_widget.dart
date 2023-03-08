import 'package:flutter/material.dart';
import 'package:crud_app/models/Delivery.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/date_symbol_data_local.dart';

class CompletedDeliveries extends StatefulWidget {
  const CompletedDeliveries({Key? key}) : super(key: key);

  @override
  State<CompletedDeliveries> createState() => _CompletedDeliveriesState();
}

class _CompletedDeliveriesState extends State<CompletedDeliveries> {
  late Future<List<Delivery>> futureDeliveries;
  DateFormat? dateFormat;
  DateFormat? timeFormat;

  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMEEEEd('tr');
    timeFormat = DateFormat.Hms('tr');
    futureDeliveries = fetchCompletedDeliveries();
  }

  Container getDeliveryIcon(delivery) {
    return Container(
        padding: const EdgeInsets.all(12),
        width: 200,
        child: Align(
          alignment: Alignment(-1, -1),
          child: Icon(Icons.task_alt, size: 57, color: Colors.blue),
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
      padding: const EdgeInsets.all(12),
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
                  child: Icon(Icons.hourglass_bottom,
                      size: 30, color: Colors.blueAccent),
                )
              ],
            ),
          ),
          Expanded(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Text(
                    dateFormat!.format(delivery.tt_delivery) + ' ' + timeFormat!.format(delivery.tt_delivery),
                    style: TextStyle(
                        color: Colors.blue.shade100,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Container getDeliveryCompleteTime(delivery){
    if (delivery.st_complete == 0) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.all(12),
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
              flex: 4,
              child: Column(
                children: <Widget>[
                  Text(
                    dateFormat!.format(delivery.tt_complete) + ' ' + timeFormat!.format(delivery.tt_complete),
                    style: TextStyle(
                        color: Colors.blue.shade100,
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

    return Stack(
      children: <Widget>[
        FutureBuilder<List<Delivery>>(
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
                                child:
                                    Text('Tamamlanan Teslimat Bulunamadı')))));
              }
              List<Delivery> deliveries = snapshot.data ?? [];
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
                  });
            })
      ],
    );
  }
}
