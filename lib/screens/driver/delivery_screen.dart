import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:crud_app/widgets/driver/delivered_person_sheet.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  DateFormat? dateFormat;
  DateFormat? timeFormat;

  @override
  void initState() {
    super.initState();
    futureActiveDelivery = getActiveDelivery();
    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMEEEEd('tr');
    timeFormat = DateFormat.Hms('tr');
  }

  bool _isLoading = false;

  String address = "";

  static const String _title = 'Teslimatım';

  tire() {
    return Column(
      children: <Widget>[
        Text(
          '-',
          style: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  card(delivery, width) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          deliveryNo(delivery, width),
          drawBorder(delivery, width),
          const SizedBox(height: 10),
          deliveryFirm(delivery, delivery.firm_name),
          deliveryAddress(delivery, width),
          deliveryStartTime(delivery, width),
          FutureBuilder<String>(
              future:
                  calculateRemainingKm(delivery.latitude, delivery.longitude),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const CircularProgressIndicator();
                }

                var distance = snapshot.data ?? "0.0";

                return remainingKm(distance.toString());
              }),
          Center(
              child: Padding(
                  padding: const EdgeInsets.all(20),
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
                  ))),
        ],
      ),
    );
  }

  drawBorder(delivery, width) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  deliveryNo(delivery, width) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            delivery.delivery_no,
            style: const TextStyle(
                color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  deliveryFirm(delivery, firm) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            tire(),
            const SizedBox(width: 5),
            Column(
              children: <Widget>[
                Text(
                  delivery.firm_name,
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }

  deliveryAddress(delivery, width) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            tire(),
            const SizedBox(width: 5),
            Flexible(
                child: Column(
              children: <Widget>[
                Text(
                  delivery.address,
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ))
          ],
        ));
  }

  deliveryStartTime(delivery, width) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            tire(),
            const SizedBox(width: 5),
            Flexible(
                child: Column(
              children: <Widget>[
                Text(
                  '${dateFormat!.format(delivery.tt_delivery)} ${timeFormat!.format(delivery.tt_delivery)}',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ))
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

  remainingKm(distance) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            tire(),
            const SizedBox(width: 5),
            Column(
              children: <Widget>[
                Text(
                  "Kalan Mesafe: ",
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  distance,
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ));
  }

  void _showDeliveredPersonSheet(BuildContext context, deliveryNo) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return DeliveredPersonSheet(deliveryNo: deliveryNo);
        });
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
                launchMapQuery(address);
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
                            firm_name: 'firm',
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

                    address = delivery.address;
                    return ListView(
                      children: [
                        card(delivery, width),
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
