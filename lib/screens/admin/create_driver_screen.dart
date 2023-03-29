import 'package:crud_app/models/Driver.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/widgets/bottomNavbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:crud_app/screens/admin/settings_screen.dart';

class CreateDriverScreen extends StatefulWidget {
  const CreateDriverScreen({Key? key}) : super(key: key);

  @override
  State<CreateDriverScreen> createState() => _CreateDriverScreenState();
}

class _CreateDriverScreenState extends State<CreateDriverScreen> {
  TextEditingController driverNameController = TextEditingController();
  TextEditingController driverEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  int selectedDriver = 1;

  static const String _title = 'Yeni Şöför Ekle';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        home: Scaffold(
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
                        controller: driverNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'İsim Soyisim',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: driverEmailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'E-Posta',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Şifre',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        create(driverNameController.text.toString(),
                            driverEmailController.text.toString(),
                            passwordController.text.toString());
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
            bottomNavigationBar:
                const BottomNavbar(userType: 'admin', index: 3)));
  }

  create(name, email, pass) async{
    showLoading();

    var result = await createDriver(name, email, pass);

    if (result) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
        content: Text('Yeni Şöför Eklendi'),
        backgroundColor: Colors.blue,
      ));

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SettingsScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Yeni Şöför Eklenemedi. Lütfen Verileri Kontrol Ediniz'),
        backgroundColor: Colors.blue,
      ));

      hideLoading();
    }
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
}
