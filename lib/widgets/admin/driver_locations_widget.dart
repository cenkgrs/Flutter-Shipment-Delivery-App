import 'package:flutter/material.dart';
import 'package:crud_app/models/Driver.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:crud_app/models/Location.dart';
import 'package:crud_app/models/Delivery.dart';
import 'package:crud_app/screens/admin/driver_details_screen.dart';

class DriverLocations extends StatefulWidget {
  const DriverLocations({Key? key}) : super(key: key);

  @override
  State<DriverLocations> createState() => _DriverLocationsState();
}

class _DriverLocationsState extends State<DriverLocations> {
  late Future<List<Locations>> futureDriverLocations;
  DateFormat? dateFormat;
  DateFormat? timeFormat;

  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormat = DateFormat.MMMMEEEEd('tr');
    timeFormat = DateFormat.Hms('tr');
    futureDriverLocations = getDriverLocations();
  }

  getDriverName(location, width) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            location.driverName,
            style: const TextStyle(
                color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  getType(Locations location) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            tire(),
            const SizedBox(width: 10),
            Text(
              typeToString(location.type),
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.blueGrey),
            )
          ],
        ));
  }

  getCurrentLocation(Locations location) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            tire(),
            const SizedBox(width: 10),
            Text(
              location.address,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.blueGrey),
            )
          ],
        ));
  }

  getLastLocationTime(Locations location) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            tire(),
            const SizedBox(width: 10),
            const Text(
              'Son Hareket: ',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            Text(
              '${dateFormat!.format(location.time!)} - ${timeFormat!.format(location.time!)}',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.blueGrey),
            )
          ],
        ));
  }

  getDeliveryNoAndDetails(Locations location) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12))),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: FutureBuilder<dynamic>(
                  future: getDeliveryNo(location.driverId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const LinearProgressIndicator();
                    }

                    var deliveryNo = snapshot.data ?? '';

                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        deliveryNo,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    );
                  })),
          Expanded(
              flex: 3,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DriverDetailsScreen(id: location.driverId)),
                      );
                    },
                    child: const Text(
                      'Detaylar',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )))
        ],
      ),
    );
  }

  tire() {
    return const Text("-",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue));
  }

  drawBorder(width) {
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

  card(location, width) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 7, child: getDriverName(location, width)),
              Expanded(
                  flex: 3,
                  child: FutureBuilder<dynamic>(
                      future: checkDriverStatus(location.driverId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const LinearProgressIndicator();
                        }

                        var status = snapshot.data ?? false;

                        if (status == 'active') {
                          return Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Teslimatta',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          );
                        }

                        return Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Beklemede',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        );
                      }))
            ],
          ),
          drawBorder(width),
          const SizedBox(height: 10),
          getType(location),
          getCurrentLocation(location),
          getLastLocationTime(location),
          getDeliveryNoAndDetails(location),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder<List<Locations>>(
        future: futureDriverLocations,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Locations> driverLocations = snapshot.data ?? [];

            if (driverLocations.isEmpty) {
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: const Visibility(
                          visible: true,
                          child: Center(
                              // scaffold of the app
                              child: Text(
                                  'Günlük Herhangi Bir Sürücü Lokasyonu Gönderilmedi')))));
            }

            return ListView.builder(
                itemCount: driverLocations.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  Locations location = driverLocations[index];

                  return card(location, width);
                });
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
                            child: Text('Sürücü Lokasyonları Getirilemedi')))));
          }

          return const LinearProgressIndicator();
        });
  }
}
