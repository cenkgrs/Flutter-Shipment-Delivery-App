import 'package:flutter/material.dart';
import 'package:crud_app/screens/admin/create_delivery_screen.dart';

class CreateDeliveryCard extends StatelessWidget {
  const CreateDeliveryCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Center(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CreateDeliveryScreen()),
          );
          ;
        },
        child: Container(
          width: width * 0.9,
          height: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                        width: 200,
                        padding: const EdgeInsets.all(12),
                        child: const Align(
                          alignment: const Alignment(-1, -1),
                          child: Icon(Icons.document_scanner_outlined,
                              size: 57, color: Colors.blue),
                        )),
                  )
                ],
              ),
              Expanded(child: Container(width: 100)),
              Row(
                children: <Widget>[
                  Container(
                    width: width * 0.9,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12))),
                    child: const Text(
                      "Yeni Teslimat Ekle",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
