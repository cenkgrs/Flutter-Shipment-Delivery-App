import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  late Future<Delivery> futureDelivery;
  late Future<List<Delivery>> futureDeliveries;
  late Future<List<Delivery>> futureWaitingDeliveries;

  String dropDownValue = "";

  void initState() {
    super.initState();

    if (widget.type == 'waiting_deliveries') {
      futureWaitingDeliveries = fetchWaitingDeliveries();
    }

    //futureDelivery = fetchDelivery();
    //futureDeliveries = fetchDeliveries();
  }

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

    return Container();
  }
}
