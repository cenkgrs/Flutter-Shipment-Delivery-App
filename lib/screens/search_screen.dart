import 'package:crud_app/models/Delivery.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:crud_app/widgets/deliveryCard.dart';

import 'package:crud_app/screens/driver/delivery_screen.dart';
import 'package:crud_app/screens/admin/drivers_screen.dart';

class SearchScreen extends StatefulWidget {
  final String userType;

  const SearchScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Delivery>> futureAllDeliveries;
  List<Delivery> filterDeliveries = [];

  bool _isLoading = false;
  bool _textVisible = false;

  @override
  void initState() {
    super.initState();
  }

  searchDeliveries(String deliveryNo) async {
    if (deliveryNo.isEmpty) {
      // Refresh the UI
      setState(() {
        _textVisible = false;
        filterDeliveries = [];
      });

      return true;
    }

    showLoading();
    filterDeliveries = await searchDelivery(deliveryNo, widget.userType);
    hideLoading();

    // Refresh the UI
    setState(() {
      _textVisible = true;
      filterDeliveries = filterDeliveries;
    });

    return true;
  }

  void showLoading() {
    setState(() => _isLoading = true);
  }

  void hideLoading() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Arama Yap',
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
              heroTag: UniqueKey(),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => widget.userType == 'driver'
                          ? const DeliveryScreen()
                          : const DriversScreen()),
                );
              },
              child: widget.userType == 'driver'
                  ? const Icon(Icons.delivery_dining)
                  : const Icon(Icons.people), //icon inside button
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            appBar: AppBar(title: const Text('Arama Yap')),
            body: ListView(children: [
              Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    onChanged: (value) async => {
                      searchDeliveries(value),
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Teslimat Ara',
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(15),
                          width: 18,
                          child: const Icon(Icons.search),
                        )),
                  )),
              filterDeliveries.isNotEmpty
                  ? ListView.builder(
                      itemCount: filterDeliveries.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) =>
                          DeliveryCard(delivery: filterDeliveries[index]),
                    )
                  : Visibility(
                      visible: _textVisible,
                      child: const Center(
                          child: Text(
                        'Sonuç bulunamadı',
                        style: TextStyle(fontSize: 16),
                      ))),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      padding: const EdgeInsets.all(50),
                      child: Visibility(
                          visible: _isLoading,
                          child: const Center(
                              // scaffold of the app
                              child: LinearProgressIndicator())))),
            ]),
            bottomNavigationBar:
                BottomNavbar(userType: widget.userType, index: 1)));
  }
}
