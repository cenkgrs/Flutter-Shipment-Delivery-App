import 'package:flutter/material.dart';
import 'package:crud_app/models/Driver.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:crud_app/models/Location.dart';

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
    dateFormat = DateFormat.yMMMMEEEEd('tr');
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

  getDriverStatus(location) {
    FutureBuilder<dynamic>(
        future: checkDriverStatus(location.driverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }

          var status = snapshot.data ?? false;

          if (status == 'active') {
            return const Row(
              children: [
                Column(
                  children: [
                    Icon(Icons.delivery_dining, size: 57, color: Colors.blue)
                  ],
                )
              ],
            );
          }

          return const Row(
            children: [
              Column(
                children: [
                  Icon(Icons.stop_circle_outlined, size: 57, color: Colors.blue)
                ],
              )
            ],
          );
        });
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
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
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
            Text(
              '${dateFormat!.format(location.time!)} - ${timeFormat!.format(location.time!)}',
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.blueGrey),
            )
          ],
        ));
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
                          return const CircularProgressIndicator();
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
          getCurrentLocation(location),
          getLastLocationTime(location),
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
                            child: Text('Sürücü Lokasyonları Getirilemedi')))));
          }
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
        });
  }
}
