import 'package:crud_app/models/Delivery.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:crud_app/main.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';

class SearchScreen extends StatelessWidget {
  final String userType;

  TextEditingController queryController = TextEditingController();

  SearchScreen({Key? key, required this.userType}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Arama Yap',
        home: Scaffold(
          appBar: AppBar(title: const Text('Arama Yap')),
          body: Container(
            margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 10,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        controller: queryController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'Teslimat Ara',
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                            prefixIcon: Container(
                              padding: const EdgeInsets.all(15),
                              width: 18,
                              child: const Icon(Icons.search),
                            )),
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          var result = await searchDelivery(
                              queryController.text.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(15),
                          child: const Icon(Icons.search),
                        ))
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: BottomNavbar(userType: userType, index: 1)
        ));
  }
}
