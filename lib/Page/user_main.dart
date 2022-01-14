// ignore_for_file: unused_field, prefer_final_fields, unused_element

import 'package:firebase_app/User/change_pass.dart';
import 'package:firebase_app/User/dashboard.dart';
import 'package:firebase_app/User/profile.dart';
import 'package:flutter/material.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int selectedIndex = 0;
  static List<Widget> _widgetOption = const <Widget>[
    Dashboard(),
    Profile(),
    ChangePass()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body:_widgetOption.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Home',
          ),
           BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
          ),
           BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Change Password',
          ),
          
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        )
    );
  }
}
