import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:crud_app/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:crud_app/themes/themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  static const String _title = 'Aydın Plastik';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => AppTheme(),
      child: Consumer<AppTheme>(builder: (context, state, child) {
        return MaterialApp(
          title: _title,
          debugShowCheckedModeBanner: false,
          /*theme: state.darkTheme
              ? ThemeData(
                  appBarTheme:
                      const AppBarTheme(color: Color.fromARGB(255, 0, 1, 1)),
                  colorScheme: const ColorScheme.dark().copyWith(
                    primary: const Color(0xff2C74B3),
                    secondary: const Color(0xffffffff),
                    outline: const Color(0xffffffff),
                    shadow: const Color(0xffffffff),
                    brightness: Brightness.dark,
                  ),
                  scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0))
              : ThemeData(
                  colorScheme: const ColorScheme.light().copyWith(
                    secondary: Colors.blue,
                    brightness: Brightness.light,
                  ),
                  scaffoldBackgroundColor: Colors.lightBlue),*/
          home: Scaffold(
              appBar: AppBar(title: const Text(_title)),
              body: const LoginScreen()),
        );
      }));
}
