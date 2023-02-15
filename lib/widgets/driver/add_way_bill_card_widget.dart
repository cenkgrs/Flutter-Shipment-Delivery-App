import 'package:crud_app/screens/driver/add_completed_delivery.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:flutter/material.dart';

class AddWayBillCard extends StatelessWidget {
  const AddWayBillCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddCompletedDeliveryScene()),
              );
              ;
            },
            child: Container(
              width: 400,
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                      width: 200,
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment(-2.5, -1),
                        child: Icon(Icons.document_scanner_outlined,
                            size: 57, color: Colors.blue),
                      )),
                  Container(
                    width: 400,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(3),
                            bottomLeft: Radius.circular(12))),
                    child: Text(
                      "Teslimat Kaydı Ekle",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )));
  }
}
