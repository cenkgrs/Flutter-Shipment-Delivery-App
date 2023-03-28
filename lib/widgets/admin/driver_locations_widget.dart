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

  Container getDriverName(location) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Center(
              child: Text(
                location.driverName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getStatusIcon(location) async {}

  getCurrentLocation(Locations location) {
    return Text(
      location.address,
      style: const TextStyle(
          fontWeight: FontWeight.normal, fontSize: 18, color: Colors.blueGrey),
    );
  }

  getLastLocationTime(Locations location) {
    return Column(
      children: [
        tire(),
        const SizedBox(width: 10),
        Text(
          '${dateFormat!.format(location.time)} ${timeFormat!.format(location.time)}',
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: Colors.blueGrey),
        )
      ],
    );
  }

  tire() {
    return const Text("-",
        style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: Colors.blueGrey));
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

                return Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        getDriverName(location),
                        const SizedBox(height: 50),
                        FutureBuilder<dynamic>(
                            future: checkDriverStatus(location.driverId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState !=
                                  ConnectionState.done) {
                                return Container(
                                    child: CircularProgressIndicator());
                              }

                              var status = snapshot.data ?? false;

                              if (status == 'active') {
                                return const Icon(Icons.delivery_dining,
                                    size: 57, color: Colors.blue);
                              }

                              return const Icon(Icons.stop_circle_outlined,
                                  size: 57, color: Colors.blue);
                            }),
                        getCurrentLocation(location),
                        getLastLocationTime(location),
                      ],
                    ));
              });
        });
  }
}
