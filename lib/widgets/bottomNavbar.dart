import 'package:flutter/material.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:crud_app/screens/search_screen.dart';
import 'package:crud_app/main.dart';

class BottomNavbar extends StatefulWidget {
  final String userType;
  final int index;

  const BottomNavbar({Key? key, required this.userType, required this.index})
      : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    navigationAction(selectedIndex) {
      if (widget.userType == 'admin') {
        switch (selectedIndex) {
          // Home Page
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(userType: widget.userType)),
            );
            break;

          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchScreen(userType: widget.userType)),
            );
            break;

          // Log Out
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
            break;
          default:
            break;
        }
      } else {
        switch (selectedIndex) {
          // Home Page
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(userType: widget.userType)),
            );
            break;

          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchScreen(userType: widget.userType)),
            );
            break;

          case 2:
            break;
          // Log Out
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyApp()),
            );
            break;
          default:
            break;
        }
      }
    }

    if (widget.userType == 'admin') {
      return BottomNavigationBar(
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
        currentIndex: widget.index,
        selectedItemColor: Colors.blue,
      );
    } else {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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
            icon: Icon(Icons.fire_truck),
            label: 'Teslimatım',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Çıkış',
          ),
        ],
        onTap: navigationAction,
        currentIndex: widget.index,
        selectedItemColor: Colors.blue,
      );
    }
  }
}
