import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/screens/home_screen.dart';
import 'package:instagram_clone_flutter/utils/global_variables.dart';
import '../screens/add_post.dart';

import '../utils/colors.dart';

class MobileSCreenLayout extends StatefulWidget {
  const MobileSCreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileSCreenLayout> createState() => _MobileSCreenLayoutState();
}

class _MobileSCreenLayoutState extends State<MobileSCreenLayout> {
  int _selectedIndex = 0;

  final List<Widget> bottomTapBarItems = const [
    HomeScreen(),
    Text('Search'),
    AddPostScreen(),
    Text('Likes'),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // OurUser user = Provider.of<UserProvider>(context).getUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomTapBarItems[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                // color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                // color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                // color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                // color: _page == 3 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                // color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
