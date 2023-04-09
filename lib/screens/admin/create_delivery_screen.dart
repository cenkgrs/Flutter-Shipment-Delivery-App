import 'package:crud_app/models/Delivery.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/widgets/selectBox.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateDeliveryScreen extends StatefulWidget {
  const CreateDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<CreateDeliveryScreen> createState() => _CreateDeliveryScreenState();
}

class _CreateDeliveryScreenState extends State<CreateDeliveryScreen> {
  TextEditingController deliveryNoController = TextEditingController();
  TextEditingController firmController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  bool _isLoading = false;

  int selectedDriver = 1;

  static const String _title = 'Yeni Teslimat Ekle';

  getSelectedDriver(int driverId) {
    selectedDriver = driverId;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: const Text(_title),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: deliveryNoController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'İrsaliye Numarası',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: firmController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Firma İsmi',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    controller: addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Teslimat Adresi',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child:
                      SelectBox(type: 'drivers', callback: getSelectedDriver),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () async {
                    create(
                        deliveryNoController.text.toString(),
                        firmController.text.toString(),
                        addressController.text.toString(),
                        selectedDriver);
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text('Ekle',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
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
        ]),
        bottomNavigationBar: const BottomNavbar(userType: 'admin', index: 0));
  }

  create(deliveryNo, firm, address, selectedDriver) async {
    showLoading();

    var result =
        await createDelivery(deliveryNo, firm, address, selectedDriver);

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Yeni Teslimat Eklendi'),
        backgroundColor: Colors.blue,
      ));

      hideLoading(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Yeni Teslimat Eklenemedi. Lütfen Verileri Kontrol Ediniz'),
        backgroundColor: Colors.blue,
      ));

      hideLoading(false);
    }
  }

  void showLoading() {
    setState(() => _isLoading = true);
  }

  void hideLoading(status) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
      });

      if (!status) {
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen(
                  userType: 'admin',
                )),
      );
    });
  }
}
