import 'package:flutter/material.dart';
import 'package:crud_app/models/Delivery.dart';
import 'package:crud_app/models/Driver.dart';

class SelectBox extends StatefulWidget {
  final String type;
  final Function callback;

  const SelectBox({Key? key, required this.type, required this.callback})
      : super(key: key);

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  late Future<List<Delivery>> futureWaitingDeliveries;

  late Future<List<Driver>> futureDrivers;

  String dropDownValue = "";
  int dropDownValueInt = 1000;

  late Driver _selectedDriver;

  @override
  void initState() {
    super.initState();

    if (widget.type == 'waiting_deliveries') {
      futureWaitingDeliveries = fetchWaitingDeliveries();
    }

    if (widget.type == 'drivers') {
      futureDrivers = fetchDrivers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genderItems = [
      'Male',
      'Female',
    ];

    if (widget.type == 'waiting_deliveries') {
      return FutureBuilder(
        future: futureWaitingDeliveries,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: DropdownButton<String>(
                      value: dropDownValue == '' ? null : dropDownValue,
                      hint: Text('İrsaliye Seç'),
                      isExpanded:
                          true, //make true to take width of parent widget
                      underline: Container(), //empty line
                      style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                      iconEnabledColor: Colors.blueAccent, //Icon color
                      items:
                          snapshot.data.map<DropdownMenuItem<String>>((item) {
                        return DropdownMenuItem<String>(
                          value: item.delivery_no,
                          child: Text(item.delivery_no),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = value!;

                          // Send this value to parent widget
                          widget.callback(value);

                          print(value);
                        });
                      },
                    ),
                  ))
              : Container(
                  child: Center(
                    child: Text('İrsaliyeler Getiriliyor...'),
                  ),
                );
        },
      );
    }

    if (widget.type == 'drivers') {
      return FutureBuilder(
        future: futureDrivers,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: DropdownButton<Driver>(
                      value: _selectedDriver,
                      hint: const Text('Sürücü Seç'),
                      isExpanded:
                          true, //make true to take width of parent widget
                      underline: Container(), //empty line
                      style: const TextStyle(
                          fontSize: 18, color: Colors.blueAccent),
                      iconEnabledColor: Colors.blueAccent, //Icon color
                      items: snapshot.data.map<DropdownMenuItem<Driver>>((item) {
                        return DropdownMenuItem<Driver>(
                          value: item.id,
                          child: Text(item.name),
                        );
                      }).toList(),
                      onChanged: (driver) {
                        setState(() {
                          _selectedDriver = driver!;

                          // Send this value to parent widget
                          widget.callback(driver.id);
                        });
                      },
                    ),
                  ))
              : const Center(
                  child: Text('Sürücüler Getiriliyor...'),
                );
        },
      );
    }

    return Container();
  }
}
