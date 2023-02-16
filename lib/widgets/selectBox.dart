import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crud_app/models/Delivery.dart';

class SelectBox extends StatefulWidget {
  final String type;

  const SelectBox({Key? key, required this.type}) : super(key: key);

  @override
  State<SelectBox> createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  late Future<Delivery> futureDelivery;
  late Future<List<Delivery>> futureDeliveries;

  void initState() {
    super.initState();
    futureDelivery = fetchDelivery();
    futureDeliveries = fetchDeliveries();
  }

  Widget build(BuildContext context) {
    final List<String> genderItems = [
      'Male',
      'Female',
    ];

    /*
    return FutureBuilder<Delivery>(
      future: futureDelivery,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
    */
    return FutureBuilder<List<Delivery>>(
        future: futureDeliveries,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // return: show loading widget
          }
          if (snapshot.hasError) {
            // return: show error widget
          }
          List<Delivery> deliveries = snapshot.data ?? [];
          return ListView.builder(
              itemCount: deliveries.length,
              //  respondedData3['data'].length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                Delivery delivery = deliveries[index];
                //  DateFormat("yyyy-MM-dd").format(
                //     DateTime.parse(respondedData3['data'][index]['appointmentDate']));

                return Text(delivery.delivery_no);
              });
        });

    /*
    return FutureBuilder<List<Delivery>>(
        future: futureDeliveries,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // return: show loading widget
          }
          if (snapshot.hasError) {
            // return: show error widget
          }
          List<Delivery> deliveries = snapshot.data ?? [];

          return DropdownButtonFormField2(
            decoration: InputDecoration(
              //Add isDense true and zero Padding.
              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              //Add more decoration as you want here
              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
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
            items: deliveries
                .map((item){
                  return DropdownMenuItem(
                    child: Text(item.delivery_no,
                      style: const TextStyle(
                        fontSize:14
                      )
                    ),
                    value: item.delivery_no
                  )
                }).toList(),
            validator: (value) {
              if (value == null) {
                return 'Lütfen irsaliye numarası seçiniz.';
              }
            },
          );
        });
        */
  }
}
