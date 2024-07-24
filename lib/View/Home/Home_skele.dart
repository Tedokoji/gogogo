import 'package:flutter/material.dart';
import 'package:gogogo/API/shareprefs.dart';
import 'package:gogogo/View/Accounts/Account.dart';
import 'package:gogogo/View/Home/Home.dart';
import 'package:gogogo/View/Order/History.dart';

class HomeSKE extends StatelessWidget {
  const HomeSKE({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;
  String number = '';
  String proName = '';
  String proURL = '';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: Material(
          elevation: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                  color: Color.fromARGB(255, 238, 238, 238),
                  width: 1.0), // Black border with width 2.0
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: 1.0), // Inner grey border
                ),
                child: NavigationBar(
                  onDestinationSelected: (int index) async {
                    setState(() {
                      currentPageIndex = index;
                    });
                    number = await getPhonenum();
                    proName = await getProName();;
                    proURL = await getproURL();
                  },
                  indicatorColor: const Color.fromARGB(255, 223, 219, 208),
                  selectedIndex: currentPageIndex,
                  destinations: const <Widget>[
                    NavigationDestination(
                      selectedIcon: Icon(Icons.home),
                      icon: Icon(Icons.home_outlined),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Badge(child: Icon(Icons.history)),
                      label: 'History',
                    ),
                    NavigationDestination(
                      icon: Badge(child: Icon(Icons.account_box)),
                      label: 'Account',
                    ),
                  ],
                ),
              ),
            ),
          )),
      body: <Widget>[
        /// Home page
        Home(),

        /// Notifications page
        History(),
        Account(number: number, proName: proName, proURL: proURL)
      ][currentPageIndex],
    );
  }
}
