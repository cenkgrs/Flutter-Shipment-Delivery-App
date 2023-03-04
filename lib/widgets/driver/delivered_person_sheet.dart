import 'package:flutter/material.dart';

class DeliveredPersonSheet extends StatefulWidget {
  const DeliveredPersonSheet({Key? key}) : super(key: key);

  @override
  _DeliveredPersonSheetState createState() => _DeliveredPersonSheetState();
}

class _DeliveredPersonSheetState extends State<DeliveredPersonSheet> {
  int? deliveredPerson;
  // ...

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: MediaQuery.of(context).size.height / 2,
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(deliveredPerson);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text('Giriş Yap',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
