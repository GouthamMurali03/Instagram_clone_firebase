import 'package:flutter/material.dart';
import '../screens/drawer.dart';

class NewMobileScreen extends StatelessWidget {
  const NewMobileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text('This is the home page'),
      ),
      drawer:  MainDrawer(),
    );
  }
}
