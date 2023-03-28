import 'package:crud_app/models/Delivery.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


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

    return true;
  }

  void showLoading() {
    setState(() => _isLoading = true);
  }

  void hideLoading() {
    Future.delayed(const Duration(milliseconds: 1500), () {
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
                        onChanged: (value) async => {
                          showLoading();
                          await searchDeliveries(value),

                          hideLoading();
                        },
                        cursorColor: Colors.grey,
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
            Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Visibility(
                    visible: _isLoading,
                    child: Center(
                      // scaffold of the app
                      child: LoadingAnimationWidget.hexagonDots(
                        color: Colors.blue,
                        size: 50,
                      ),
                    )))),
              ],
            )
            
          ),
          bottomNavigationBar: BottomNavbar(userType: widget.userType, index: 1)
        ));
  }
}
