import 'package:crud_app/models/Delivery.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:crud_app/main.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';

class SearchScreen extends StatefulWidget {
  final String userType;

  const SearchScreen({Key? key, required this.userType}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<Delivery>> futureAllDeliveries;
  List<Delivery> filterDeliveries = [];

  TextEditingController queryController = TextEditingController();

  void initState() async{
    super.initState();
  }

  searchDeliveries(String deliveryNo) async {

    if (deliveryNo.isNotEmpty) {
      filterDeliveries = await searchDelivery(deliveryNo);
    }

    // Refresh the UI
    setState(() {
      filterDeliveries = filterDeliveries;
    });
  }

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
                        onChanged: (value) => {
                          searchDeliveries(value),
                        },
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
                  ],
                ),
                Row(
              children: [
                Expanded(
                  child: filterDeliveries.isNotEmpty
                      ? ListView.builder(
                          itemCount: filterDeliveries.length,
                          itemBuilder: (context, index) => Card(
                            key: ValueKey(filterDeliveries[index].delivery_no),
                            color: Colors.amberAccent,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: Text(
                                filterDeliveries[index].delivery_no.toString(),
                                style: const TextStyle(fontSize: 24),
                              ),
                              title: Text(filterDeliveries[index].driver_name),
                              subtitle: Text(
                                  '${filterDeliveries[index].address.toString()} gidecek'),
                            ),
                          ),
                        )
                      : const Text(
                          'Sonuç bulunamadı',
                          style: TextStyle(fontSize: 24),
                        ),
                ),
              ],
            ),
              ],
            )
            
          ),
          bottomNavigationBar: BottomNavbar(userType: widget.userType, index: 1)
        ));
  }
}
