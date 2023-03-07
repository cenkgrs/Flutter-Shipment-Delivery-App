import 'dart:ui';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:convert';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:crud_app/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 100.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Kullanıcı Adı',
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
                onTap: () {
                  login(nameController.text.toString(),
                      passwordController.text.toString());
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
    );
  }

  void login(String email, password) async {
    showLoading();

    try {
      final response = await http.post(
          Uri.parse('${Constant.baseUrl}/login'),
          headers: {'Accept': 'application/json;'},
          body: {'email': 'cenkgrs@gmail.com', 'password': '123456'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Kullanıcı girişi başarılı'),
            backgroundColor: Colors.blue,
          ));

          hideLoading();

          // Create storage instance
          const storage = FlutterSecureStorage();

          // Save api token on local storage
          await storage.write(key: 'token', value: data['token']);

          var user_type = data['user_type'];

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(userType: user_type)),
          );
        }
      } else {
        throw Exception(
            'Kullanıcı adı veya şifre yanlış. Lütfen tekrar deneyiniz.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
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
