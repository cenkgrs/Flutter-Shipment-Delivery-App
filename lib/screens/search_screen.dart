import 'package:flutter/material.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:crud_app/main.dart';


class SearchScreen extends StatelessWidget {
  final String userType;

  SearchScreen({Key? key, required this.userType}) : super(key: key);

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {

    navigationAction(selectedIndex) {

      switch (selectedIndex) {
        // Home Page
        case 0: 
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(userType: userType)
              ),
            );
            break;
        
        case 1: 
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(userType: userType)
              ),
          );
          break;

        // Log Out
        case 2:
           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyApp()
              ),
            );
          break;
        default: 
          break;
      }
    }



    return MaterialApp(
        title: 'Arama Yap',
        home: Scaffold(
          appBar: AppBar(title: const Text('Aydın Plastik')),
          body: Container(),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Ana Sayfa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Ara',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'Çıkış',
              ),
            ],
            onTap: navigationAction,
            currentIndex: selectedIndex,
            selectedItemColor: Colors.blue,
          ),
        ));
  }
}
