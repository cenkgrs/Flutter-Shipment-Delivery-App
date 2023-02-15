import 'package:flutter/material.dart';

class WayBillListCard extends StatelessWidget {
  const WayBillListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 400,
          height: 100,
          child: Center(child: Text('İrsaliye Listesi')),
        ),
      ),
    );
  }
}
