import 'package:flutter/material.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:crud_app/screens/admin/create_driver_screen.dart';
import 'package:crud_app/models/Driver.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:crud_app/screens/admin/drivers_screen.dart';
import 'package:crud_app/screens/admin/driver_details_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Future<List<Driver>> futureDrivers;
  static const String _title = 'Ayarlar';

  @override
  void initState() {
    super.initState();
    futureDrivers = fetchDrivers();
  }

  createDriverCard(width) {
    return SizedBox(
      width: width * 1,
      height: 50,
      child: FittedBox(
          child: FloatingActionButton.extended(
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateDriverScreen()),
                );
              },
              backgroundColor: Colors.blue,
              splashColor: Colors.blueAccent,
              icon: const Icon(Icons.add),
              label: const Text('Şöför Ekle'))),
    );
  }

  Container getDriverName(driver) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Text(
              driver.name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  driversList(width) {
    return FutureBuilder<List<Driver>>(
        future: futureDrivers,
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
                            child: Text('Sürücü Verisi Getirilemedi')))));
          }
          List<Driver> drivers = snapshot.data ?? [];

          if (drivers.isEmpty) {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: const Visibility(
                        visible: true,
                        child: Center(
                            // scaffold of the app
                            child: Text('Sürücü Bulunamadı')))));
          }

          void _confirmationBox(BuildContext context, list, i) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Emin misiniz ?'),
                content: const Text(
                    'İlgili sürücü ve sürücüde aktif olan teslimatlar silinecek'),
                actions: [
                  SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        list.removeAt(i);
                      },
                      child: const Text(
                        'Sil',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'İptal',
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
              itemCount: drivers.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                Driver driver = drivers[index];

                /*
                return GestureDetector(
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DriverDetailsScreen(id: driver.id)),
                          )
                        },
                    child: Card(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            getDriverName(driver),
                            const SizedBox(height: 50),
                          ],
                        )));
                */

                return Slidable(
                  key: UniqueKey(),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {
                      _confirmationBox(context, drivers, index);
                    }),
                    children: [
                      SlidableAction(
                        onPressed: (context) =>
                            _confirmationBox(context, drivers, index),
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Sil',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      '${index + 1} - ${drivers[index].name}',
                      textAlign: TextAlign.left,
                    ),
                  ),
                );
              });
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
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: const Text(_title),
              centerTitle: true,
            ),
            body: ListView(children: [
              const SizedBox(height: 10),
              createDriverCard(width),
              driversList(width),
            ]),
            bottomNavigationBar:
                const BottomNavbar(userType: 'admin', index: 0)));
  }
}
