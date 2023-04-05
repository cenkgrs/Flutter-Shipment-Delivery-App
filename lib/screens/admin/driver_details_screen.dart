import 'dart:ffi';

import 'package:crud_app/models/Location.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:crud_app/screens/admin/drivers_screen.dart';
import 'package:crud_app/models/Driver.dart';

// Models
import 'package:crud_app/models/Delivery.dart';
import 'package:location/location.dart';

class DriverDetailsScreen extends StatefulWidget {
  final int id;

  const DriverDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DriverDetailsScreen> createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  late Future<Driver> futureDriver;
  late Future<List<Locations>> futureLocations;

  DateFormat? dateFormat;
  DateFormat? timeFormat;

  @override
  void initState() {
    super.initState();
    futureDriver = getDriver(widget.id);
    futureLocations = getLocations(widget.id);

    initializeDateFormatting();
    dateFormat = DateFormat.yMMMMEEEEd('tr');
    timeFormat = DateFormat.Hms('tr');
  }

  bool _isLoading = false;

  String address = "";

  static const String _title = 'Şöför Bilgileri';

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

  tire() {
    return const Text("-",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blue));
  }

  /* Driver Profile Card */
  getDriverName(driver, width) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            driver.name,
            style: const TextStyle(
                color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  getDriverStatus(driver, width) {
    FutureBuilder<dynamic>(
        future: checkDriverStatus(driver.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LinearProgressIndicator();
          }

          var status = snapshot.data ?? false;

          if (status == 'active') {
            return Row(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Teslimatta',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )),
                )
              ],
            );
          }

          return Row(
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Beklemede',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          );
        });
  }

  driverProfileCard(driver, width) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 7, child: getDriverName(driver, width)),
              Expanded(flex: 3, child: getDriverStatus(driver, width)),
            ],
          ),
          drawBorder(width),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  /* Driver Location Card */
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

  getLocationTime(Locations location) {
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
                  fontSize: 14,
                  color: Colors.blueGrey),
            )
          ],
        ));
  }

  openLocationButton(location) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12),
              bottomLeft: Radius.circular(12))),
      child: Row(
        children: [
          const Expanded(flex: 8, child: Text('')),
          Expanded(
              flex: 3,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      launchMapCoordinates(location.latitude, location.longitude);
                    },
                    child: const Text(
                      'Konuma Git',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )))
        ],
      ),
    );
  }

  driverLocationCard(location, width) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              getType(location),
              getLocationTime(location),
              openLocationButton(location),
            ],
          )
        ],
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DriversScreen()),
                );
              },
              child: const Icon(Icons.people), //icon inside button
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            appBar: AppBar(
              title: const Text(_title),
              centerTitle: true,
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                FutureBuilder<Driver>(
                    future: futureDriver,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Driver? driver = snapshot.data;

                        if (driver == null) {
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
                                              'İlgili Sürücü Bulunamadı')))));
                        }

                        return driverProfileCard(driver, width);
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
                                            'Sürücü Verileri Getirilemedi')))));
                      }

                      return const LinearProgressIndicator();
                    }),
                FutureBuilder<List<Locations>>(
                    future: futureLocations,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Locations> locations = snapshot.data ?? [];

                        if (locations.isEmpty) {
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
                                              'Sürücüyle ilgili lokasyon verisi bulunamadı')))));
                        }

                        return ListView.builder(
                            itemCount: locations.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              Locations location = locations[index];

                              return driverLocationCard(location, width);
                            });
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
                                            'Sürücünun Lokasyon Verileri Getirilemedi')))));
                      }

                      return const LinearProgressIndicator();
                    }),
              ],
            ),
            bottomNavigationBar:
                const BottomNavbar(userType: 'admin', index: 0)));
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
