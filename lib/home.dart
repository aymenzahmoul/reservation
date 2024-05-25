import 'package:flutter/material.dart';
import 'package:flutter_auth_app/page/CategoryPage.dart';
import 'package:flutter_auth_app/page/MaterielPage.dart';
import 'package:flutter_auth_app/page/NotificationPage.dart';
import 'package:flutter_auth_app/page/ProfilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Accueil'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.meeting_room), text: 'Salle'),
              Tab(icon: Icon(Icons.build), text: 'Matériel'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CategoryPage(category: 'Salle'),
            CategoryPages(category: 'Matériel'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
