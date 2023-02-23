import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crud_app/models/Delivery.dart';
import 'package:crud_app/models/Driver.dart';

class SelectBox extends StatefulWidget {
  final String type;
  final Function callback;

  const SelectBox({Key? key, required this.type, required this.callback}) : super(key: key);

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  late Future<Delivery> futureDelivery;
  late Future<List<Delivery>> futureDeliveries;

  String dropDownValue = "";

  void initState() {
    super.initState();
    //futureDelivery = fetchDelivery();
    futureDeliveries = fetchDeliveries();
  }

  Widget build(BuildContext context) {
    final List<String> genderItems = [
      'Male',
      'Female',
    ];

    if (widget.type == 'waiting_deliveries') {
      return FutureBuilder(
        future: futureDeliveries,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: DropdownButton<String>(
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

    return FutureBuilder(
        future: futureDeliveries,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? DropdownButtonFormField2<String>(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'İrsaliye Numarası Seçiniz',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: snapshot.data.map<DropdownMenuItem<String>>((item) {
                    return DropdownMenuItem<String>(
                      value: item.delivery_no,
                      child: Text(item.delivery_no),
                    );
                  }).toList(),
                )
              : Container(
                  child: Center(
                    child: Text('İrsaliyeler Getiriliyor...'),
                  ),
                );
        });
  }
}
