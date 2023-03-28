import 'package:flutter/material.dart';
import 'package:crud_app/models/Delivery.dart';
import 'package:crud_app/models/Location.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyDeliveriesTable extends StatefulWidget {
  const MyDeliveriesTable({Key? key}) : super(key: key);

  @override
  State<MyDeliveriesTable> createState() => _MyDeliveriesTableState();
}

class _MyDeliveriesTableState extends State<MyDeliveriesTable> {
  late Future<List<Delivery>> futureDeliveries;

  bool _isLoading = false;

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
      if (delivery.st_delivery == 1) {
        return Container(
            padding: const EdgeInsets.all(12),
            width: 200,
            child: const Align(
              alignment: Alignment(-1, -1),
              child: Icon(Icons.access_time, size: 57, color: Colors.blue),
            ));
      }

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

  Row getFirmName(delivery) {
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
              delivery.firm_name,
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

  GestureDetector getDeliveryAction(delivery) {
    if (delivery.status == 0 && delivery.st_delivery == 0) {
      return GestureDetector(
          onTap: () async {
            showLoading();

            var result = await startDelivery(delivery);

            if (result['status'] == true) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Teslimat Başlatıldı !'),
                backgroundColor: Colors.blue,
              ));

              var result = await setLocation();

              hideLoading();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(result['exception']),
                backgroundColor: Colors.blue,
              ));

              hideLoading();
            }
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
                                color: Theme.of(context).colorScheme.secondary,
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
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
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
                                              const SizedBox(height: 3),
                                              getFirmName(delivery),
                                              const SizedBox(height: 3),
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
                                          flex: 5,
                                          child: getDeliveryNo(delivery, width),
                                        ),
                                        Expanded(
                                            flex: 5,
                                            child: getDeliveryAction(delivery))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )));
                  });
            }),
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
      ],
    );
  }
}
