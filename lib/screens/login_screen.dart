import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crud_app/models/Product.dart';


class LoginScreen extends StatefulWidget {
    const LoginScreen({Key? key}) : super(key: key);

    @override
    State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    @override
    Widget build(BuildContext context) {

      return Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      height: 100.0,
                      child: Image.asset('assets/images/logo.jpeg'),
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
              SizedBox(
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
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Giriş Yap',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      )
                    ),
                  ),
                ),
              ),
            ],
          ));
    }

    void login(String email, password) async {

        try {
            final response = await http.post(Uri.parse('http://bysurababy.com/api/logn'),
                body: {'email': email, 'password': password});

            if (response.statusCode == 200) {

                var data = jsonDecode(response.body);

                if (data['status'] == true) {

                }
            } else {

                throw Exception('Kullanıcı adı veya şifre yanlış. Lütfen tekrar deneyiniz.');
            }

        } catch(e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    e.toString(),
                ),
                backgroundColor: Colors.blue,
            ));
        }

    /*
    try {
      Response response = await post(Uri.parse('http://bysurababy.com/api/login'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);


        if (data[0] == true) {
          print('Login successfully');
        } else {
          print('failed');
        }
      } else {
          print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
    */

  }
}