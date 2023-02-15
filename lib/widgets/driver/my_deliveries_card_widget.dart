import 'package:flutter/material.dart';

class MyDeliveriesCard extends StatelessWidget {
  const MyDeliveriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 150,
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
            child: Icon(Icons.person, size: 57, color: Colors.blue),
            padding: const EdgeInsets.all(12),
          ),
          Container(
            width: 150,
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Text(
              "Teslimatlarım",
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            padding: const EdgeInsets.all(12),
          )
        ],
      ),
    ));
  }
}
