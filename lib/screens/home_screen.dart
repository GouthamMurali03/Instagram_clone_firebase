import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:instagram_clone_flutter/screens/Dummy_screen.dart';
import 'package:instagram_clone_flutter/screens/drawer.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: mobileBackgroundColor,
      ),
      body: const Center(
        child: Text('Use the drawer to move to other screens'),
      ),
      drawer: MainDrawer(),
    );
  }
}
