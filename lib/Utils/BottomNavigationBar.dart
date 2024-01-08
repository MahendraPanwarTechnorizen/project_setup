import 'package:flutter/material.dart';
import 'package:project_setup/Screen/TabBarScreen/ProductList.dart';

import 'package:project_setup/Utils/AppColors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  static  List<Widget> widgetOptions = <Widget>[
    Container(color: Colors.cyan,),
    ShimmerScreen(),
    Container(color:Colors.green),
  ];
  int _selectedIndex=0;
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('_selectedIndex on change tab-----------$_selectedIndex');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon:Icon(Icons.home,color: AppColors.primary,),
            label: 'Home',
            backgroundColor: Colors.green,
          ),  BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon:Icon(Icons.search,color: AppColors.primary,),
            label: 'Search',
            backgroundColor: Colors.green,
          ),  BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            activeIcon:Icon(Icons.menu,color: AppColors.primary,),
            label: 'Menu',
            backgroundColor: Colors.green,
          ),
        ],
        onTap: onItemTapped,
        selectedLabelStyle: TextStyle(color: AppColors.primary),
        selectedItemColor: AppColors.primary,
        currentIndex: _selectedIndex,
        // backgroundColor: AppColors.primary,
      ),

    );
  }
}
