import 'package:flutter/material.dart';
import 'package:crud_app/screens/home_page_screen.dart';
import 'package:crud_app/screens/search_screen.dart';
import 'package:crud_app/screens/driver/delivery_screen.dart';
import 'package:crud_app/screens/admin/drivers_screen.dart';
import 'package:crud_app/screens/admin/settings_screen.dart';
import 'package:crud_app/screens/driver/completed_deliveries_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    navigationAction(selectedIndex) {
      if (widget.userType == 'admin') {
        switch (selectedIndex) {
          // Home Page
          case 0:
            if (widget.index == 0) {
              break;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(userType: widget.userType)),
            );
            break;

          case 1:
            if (widget.index == 1) {
              break;
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SearchScreen(userType: widget.userType)),
            );
            break;

          case 2:
            if (widget.index == 2) {
              break;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DriversScreen()),
            );
            break;

          case 3:
            if (widget.index == 3) {
              break;
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
            break;
          // Log Out
          case 4:
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DeliveryScreen()),
            );
            break;

          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CompletedDeliveriesScene()),
            );

            break;
          // Log Out
          case 4:
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

    adminBottomNavbar() {
      return BottomAppBar(
          notchMargin: 5,
          color: Colors.blue,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                padding: const EdgeInsets.only(left: 20),
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  navigationAction(0);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  navigationAction(1);
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  navigationAction(3);
                },
              ),
              IconButton(
                padding: const EdgeInsets.only(right: 20),
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  navigationAction(4);
                },
              )
            ],
          ));
    }

    driverBottomNavbar() {
      return BottomAppBar(
        notchMargin: 5,
        color: Colors.blue,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              padding: EdgeInsets.only(left: 20),
              icon: const Icon(Icons.home, color: Colors.white),
              onPressed: () {
                navigationAction(0);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                navigationAction(1);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.done_outline_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                navigationAction(3);
              },
            ),
            IconButton(
              padding: const EdgeInsets.only(right: 20),
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                navigationAction(4);
              },
            )
          ],
        ),
      );
    }

    if (widget.userType == 'admin') {
      return adminBottomNavbar();
    } else {
      return driverBottomNavbar();
    }
  }
}
