import 'package:flutter/material.dart';
import 'package:crud_app/screens/admin/waiting_deliveries_screen.dart';

class DriverLocations extends StatelessWidget {
  const DriverLocations({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Center(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const WaitingDeliveriesScreen()),
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
                offset: Offset(0, 3),
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
                        child: Align(
                          alignment: Alignment(-1, -1),
                          child: Icon(Icons.share_location,
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
                    child: Text(
                      "Şöförler Şuan Nerede ?",
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
