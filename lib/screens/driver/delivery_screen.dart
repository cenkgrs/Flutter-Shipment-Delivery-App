import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:crud_app/widgets/driver/delivered_person_sheet.dart';
import 'package:crud_app/screens/home_page_screen.dart';

// Models
import 'package:crud_app/models/Delivery.dart';
import 'package:crud_app/models/Location.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  late Future<Delivery> futureActiveDelivery;

  @override
  void initState() {
    super.initState();
    futureActiveDelivery = getActiveDelivery();
  }

  bool _isLoading = false;

  static const String _title = 'Teslimatım';

  deliveryNo(delivery, width) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              children: <Widget>[
                Icon(Icons.numbers, size: 25, color: Colors.blue),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  delivery.delivery_no,
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ));
  }

  deliveryAddress(delivery, width) {
    return Card(
        child: Row(
      children: [
        Column(
          children: [const Text("Adres"), Text(delivery.address)],
        ),
      ],
    ));
  }

  cancelDeliveryButton(delivery, width) {
    return SizedBox(
      width: width * 0.4,
      child: FittedBox(
          child: FloatingActionButton.extended(
              heroTag: UniqueKey(),
              onPressed: () async {
                var result = await cancelDelivery(delivery);

                if (result['status'] == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(userType: 'driver')),
                  );

                  hideLoading();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(result['exception']),
                    backgroundColor: Colors.blue,
                  ));

                  hideLoading();
                }
              },
              backgroundColor: Colors.redAccent,
              splashColor: Colors.red,
              icon: const Icon(Icons.cancel_outlined),
              label: const Text('Teslimatı İptal Et'))),
    );
  }

  completeDeliveryButton(delivery, width) {
    return SizedBox(
      width: width * 0.4,
      child: FittedBox(
          child: FloatingActionButton.extended(
              heroTag: UniqueKey(),
              onPressed: () {
                _showDeliveredPersonSheet(context, delivery.delivery_no);
              },
              splashColor: Colors.lightBlue,
              icon: const Icon(Icons.done_all_sharp),
              label: const Text('Teslimatı Tamamla'))),
    );
  }

  void _showDeliveredPersonSheet(BuildContext context, deliveryNo) async {
    /*String? deliveredPerson = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          //3
          return const DeliveredPersonSheet();
        });

    completeDelivery(deliveryNo, "asd");*/

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          //3
          return DeliveredPersonSheet(deliveryNo: deliveryNo);
        });
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
        title: _title,
        home: Scaffold(
            floatingActionButton: FloatingActionButton(
              heroTag: UniqueKey(),
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeliveryScreen()),
                );
              },
              child: const Icon(Icons.gps_fixed),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            appBar: AppBar(
              title: const Text(_title),
              centerTitle: true,
            ),
            body: Stack(children: <Widget>[
              FutureBuilder<Delivery>(
                  future: getActiveDelivery(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: const Visibility(
                                  visible: true,
                                  child: Center(
                                      // scaffold of the app
                                      child: Text(
                                          'Aktif Teslimatınız Bulunmamaktadır')))));
                    }
                    Delivery delivery = snapshot.data ??
                        Delivery(
                            delivery_no: '1',
                            driver_id: 1,
                            driver_name: 'null',
                            address: 'address',
                            st_delivery: 1,
                            tt_delivery: DateTime.now(),
                            st_complete: 1,
                            tt_complete: DateTime.now(),
                            delivered_person: 'delivered_person',
                            distance: 0,
                            latitude: 00,
                            longitude: 0,
                            status: 0);
                    return ListView(
                      children: [
                        Center(
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
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
                                                bottomRight:
                                                    Radius.circular(12),
                                                bottomLeft:
                                                    Radius.circular(12))),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 10,
                                              child: getDeliveryNo(
                                                  delivery, width),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ))),
                        deliveryNo(delivery, width),
                        deliveryAddress(delivery, width),
                        Center(
                          child: Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        cancelDeliveryButton(delivery, width),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        completeDeliveryButton(delivery, width)
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    );
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
            ]),
            bottomNavigationBar:
                const BottomNavbar(userType: 'driver', index: 2)));
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
}
